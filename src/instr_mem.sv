import riscky_pkg::*;

module instr_mem(
    input logic rst_n, // rst is active low
    input  logic [IMEM_AW-1:0]     addr,       // word index
    output logic [ILEN-1:0]        rd_instr
);

logic [ILEN-1:0] imem [0:IMEM_WORDS-1];

assign rd_instr = (!rst_n) ? {ILEN{1'b0}} : imem[addr];

// initial begin
//     $readmemh("memfile.hex",imem);
// end

//test purposes
initial begin
  imem[0]  = 32'h0000_0000; // PC = 0
  imem[4]  = 32'h0000_0004; // PC = 4
  imem[8]  = 32'h0000_0008; // PC = 8
  imem[12] = 32'h0000_000C; // PC = 12
  imem[16] = 32'h0000_0010; // PC = 16
  imem[20] = 32'h0000_0014; // PC = 20
  imem[24] = 32'h0000_0018; // PC = 24
  imem[28] = 32'h0000_001C; // PC = 28
  imem[32] = 32'h0000_0020; // PC = 32
  imem[36] = 32'h0000_0024; // PC = 36
  imem[40] = 32'h0000_0028; // PC = 40
  imem[44] = 32'h0000_002C; // PC = 44
  imem[48] = 32'h0000_0030; // PC = 48
  imem[52] = 32'h0000_0034; // PC = 52
  imem[56] = 32'h0000_0038; // PC = 56
  imem[60] = 32'h0000_003C; // PC = 60
end


endmodule