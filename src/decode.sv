import riscky_pkg::*;

module decode(
    input clk,
    input rst_n,
    input [ILEN-1:0] instr_d,
    input [XLEN-1:0] pc_d,
    input [XLEN-1:0] pc_plus4_d,
    input [XLEN-1:0] result_w,
    input reg_write_w,
    input [4:0] rd_w,

    output logic reg_write_e,
    output logic result_src_e,
    output logic mem_write_e,
    output logic jump_e,
    output logic branch_e,
    output logic [2:0] alu_control_e,
    output logic alu_src_e,

    output logic [XLEN-1:0] rd1_e,
    output logic [XLEN-1:0] rd2_e,
    output logic [XLEN-1:0] pc_e,
    output logic [XLEN-1:0] pc_plus4_e,

    output logic [4:0] rs1_e,
    output logic [4:0] rs2_e,
    output logic [4:0] rd_e,
    output logic [XLEN-1:0] imm_ext_e    
);

// wires
logic reg_write_d, alu_src_d, mem_write_d, result_src_d, branch_d;
logic [1:0] imm_src_d;
logic [2:0] alu_control_d;
logic [XLEN-1:0] rd1_d, rd2_d, imm_ext_d;

// registers
logic reg_write_d_reg, alu_src_d_reg, mem_write_d_reg, result_src_d_reg, branch_d_reg;
logic [2:0] alu_control_d_reg;
logic [XLEN-1:0] rd1_d_reg, rd2_d_reg, imm_ext_d_reg;
logic [4:0] rs1_d_reg, rs2_d_reg, rd_d_reg;
logic [XLEN-1:0] pc_d_reg, pc_plus4_d_reg;


// instantiating modules

// register file
register_file RF(
    .clk(clk),
    .rst_n(rst_n),
    .we(reg_write_w),
    .D3(result_w),
    .A1(instr_d[19:15]),
    .A2(instr_d[24:20]),
    .A3(rd_w),
    .RD1(rd1_d),
    .RD2(rd2_d)
);

// sign extender
extender extend(
    .instr(instr_d[XLEN-1:0]),
    .imm_sel(imm_src_d),
    .imm_ext(imm_ext_d)
);

// control unit
control con(
    .op(instr_d[6:0]),
    .funct7(instr_d[31:25]),
    .funct3(instr_d[14:12]),

    .reg_write(reg_write_d),
    .alu_src(imm_src_d),
    .mem_write(mem_write_d),
    .result_src(result_src_d),
    .branch(branch_d),
    .imm_src(imm_src_d),
    .alu_control(alu_control_d)
);

always @(posedge clk) begin
if(!rst_n)begin
reg_write_d_reg <= 1'b0;
alu_src_d_reg <= 1'b0;
mem_write_d_reg <= 1'b0;
result_src_d_reg <= 1'b0;
branch_d_reg <= 1'b0;
alu_control_d_reg <= 3'b000;
rd1_d_reg <= 64'd0;
rd2_d_reg <= 64'd0;
imm_ext_d_reg <= 64'd0;
rd_d_reg <= 5'd0;
pc_d_reg <= 64'd0;
pc_plus4_d_reg <= 64'd0;
rs1_d_reg <= 5'd0;
rs2_d_reg <= 5'd0;
end
else begin
reg_write_d_reg <= reg_write_d;
alu_src_d_reg <= alu_src_d;
mem_write_d_reg <= mem_write_d;
result_src_d_reg <= result_src_d;
branch_d_reg <= branch_d;
alu_control_d_reg <= alu_control_d;
rd1_d_reg <= rd1_d;
rd2_d_reg <= rd2_d;
imm_ext_d_reg <= imm_ext_d;
rd_d_reg <= instr_d[11:7];
pc_d_reg <= pc_d;
pc_plus4_d_reg <= pc_plus4_d;
rs1_d_reg <= instr_d[19:15];
rs2_d_reg <= instr_d[24:20];
end
end

// output assignments.
assign reg_write_e = reg_write_d_reg;
assign alu_src_e = alu_src_d_reg;
assign mem_write_e = mem_write_d_reg;
assign result_src_e = result_src_d_reg;
assign branch_e = branch_d_reg;
assign alu_control_e = alu_control_d_reg;
assign rd1_e = rd1_d_reg;
assign rd2_e = rd2_d_reg;
assign imm_ext_e = imm_ext_d_reg;
assign rd_e = rd_d_reg;
assign pc_e = pc_d_reg;
assign pc_plus4_e = pc_plus4_d_reg;
assign rs1_e = rs1_d_reg;
assign rs2_e = rs2_d_reg;
endmodule