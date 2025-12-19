import riscky_pkg::*;

class riscv_instr;

  // ---------- Random semantic fields ----------
  rand bit [6:0]  opcode;
  rand bit [4:0]  rd, rs1, rs2;
  rand bit [2:0]  funct3;
  rand bit [6:0]  funct7;

  rand bit [XLEN-1:0] imm;   // raw immediate (we'll slice as needed)

  // Final instruction word
  bit [XLEN-1:0] instr;

  // ---------- Opcode distribution ----------
  constraint c_opcode_dist {
    opcode dist {
      7'b0110011 := 30, // R-type
      7'b0010011 := 20, // I-type ALU
      7'b0000011 :=  19, // LOAD
      7'b0100011 :=  15, // STORE
      7'b1100011 :=  13, // BRANCH
      7'b1101111 :=  1, // JAL
      7'b1100111 :=  1, // JALR
      7'b0110111 :=  1, // LUI
      7'b0010111 :=  1  // AUIPC
    };
  }

  // ---------- Register constraints ----------
  constraint c_regs {
    rd  inside {[1:31]}; // avoid x0 as destination
    rs1 inside {[0:31]};
    rs2 inside {[0:31]};
  }

  // ---------- Opcode-dependent legality ----------
  constraint c_legal_fields {

    // R-type
    if (opcode == 7'b0110011) {
      funct3 inside {3'b000,3'b001,3'b010,3'b011,
                      3'b100,3'b101,3'b110,3'b111};
      funct7 inside {7'b0000000,7'b0100000}; // add/sub, srl/sra
    }

    // I-type ALU
    if (opcode == 7'b0010011) {
      funct3 inside {3'b000,3'b010,3'b011,
                      3'b100,3'b110,3'b111,
                      3'b001,3'b101};

      if (funct3 inside {3'b001,3'b101})
        funct7 inside {7'b0000000,7'b0100000};
      else
        funct7 == 7'b0000000;
    }

    // LOAD
    if (opcode == 7'b0000011) {
      funct3 inside {3'b000,3'b001,3'b010,3'b100,3'b101};
    }

    // STORE
    if (opcode == 7'b0100011) {
      funct3 inside {3'b000,3'b001,3'b010};
    }

    // BRANCH
    if (opcode == 7'b1100011) {
      funct3 inside {3'b000,3'b001,3'b100,
                      3'b101,3'b110,3'b111};
    }

    // JALR
    if (opcode == 7'b1100111) {
      funct3 == 3'b000;
    }

    // LUI / AUIPC
    if (opcode inside {7'b0110111,7'b0010111}) {
      funct3 == 3'b000;
      funct7 == 7'b0000000;
      rs1 == 5'b00000;
    }
  }

  // ---------- Post-randomize packing ----------
  function void post_randomize();
    instr = '0;

    case (opcode)

      // R-type
      7'b0110011:
        instr = {funct7, rs2, rs1, funct3, rd, opcode};

      // I-type (ALU / LOAD / JALR)
      7'b0010011,
      7'b0000011,
      7'b1100111:
        instr = {imm[11:0], rs1, funct3, rd, opcode};

      // S-type (STORE)
      7'b0100011:
        instr = {imm[11:5], rs2, rs1, funct3, imm[4:0], opcode};

      // B-type (BRANCH)
      7'b1100011:
        instr = {imm[12], imm[10:5], rs2, rs1,
                 funct3, imm[4:1], imm[11], opcode};

      // U-type (LUI / AUIPC)
      7'b0110111,
      7'b0010111:
        instr = {imm[31:12], rd, opcode};

      // J-type (JAL)
      7'b1101111:
        instr = {imm[20], imm[10:1], imm[11],
                 imm[19:12], rd, opcode};
    endcase
  endfunction

endclass


module decode_tb();

// signal declarations.
    logic clk;
    logic rst_n;
    logic [ILEN-1:0] instr_d;
    logic [XLEN-1:0] pc_d;
    logic [XLEN-1:0] pc_plus4_d;
    logic [XLEN-1:0] result_w;
    logic reg_write_w;
    logic [4:0] rd_w;

    logic reg_write_e;
    logic result_src_e;
    logic mem_write_e;
    logic jump_e;
    logic branch_e;
    logic [2:0] alu_control_e;
    logic alu_src_e;

    logic [XLEN-1:0] rd1_e;
    logic [XLEN-1:0] rd2_e;
    logic [XLEN-1:0] pc_e;
    logic [XLEN-1:0] pc_plus4_e;

    logic [4:0] rs1_e;
    logic [4:0] rs2_e;
    logic [4:0] rd_e;
    logic [XLEN-1:0] imm_ext_e;


// dut instantiation
decode dut(.*);

// clocking and rest
initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
 rst_n = 0;
 #5;
 rst_n = 1;
end

initial begin
pc_d = 64'h0;
pc_plus4_d = 64'h4;

@(posedge rst_n);

forever begin
@(posedge clk);
pc_d = pc_d + 64'h4;
pc_plus4_d = pc_plus4_d + 64'h4;
end
end
// class initialize
riscv_instr gen;

initial begin
    gen = new();

    repeat(25) begin

        gen.randomize();
        instr_d = gen.instr;
        
        @(posedge clk);
    end
    $finish;
end    
//  

endmodule