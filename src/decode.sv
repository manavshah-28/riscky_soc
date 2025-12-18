import riscky_pkg::*;

module decode(
    input clk,
    input rst_n,
    input [ILEN-1:0] instr_d,
    input [XLEN-1:0] pc_d,
    input [XLEN-1:0] pc_plus4_d,

    output logic reg_write_e,
    output logic result_src_e,
    output logic mem_write_e,
    output logic jump_e,
    output logic branch_e,
    output logic alu_control_e,
    output logic alu_src_e,

    output logic rd1_e,
    output logic rd2_e,
    output logic pc_e,
    output logic rd_e,
    output logic imm_ext_e,
    output logic pc_plus4_e
    
);

endmodule