import riscky_pkg::*;

module extender(
    input [ILEN-1:0] instr,
    input [1:0] imm_sel,
    output [XLEN-1:0] imm_ext
);

assign imm_ext = (imm_sel == 2'b00) ? {{(XLEN-12){instr[31]}}, instr[31:20]} : // I type
                 (imm_sel == 2'b01) ? {{(XLEN-12){instr[31]}}, instr[31:25], instr[11:7]} : // S type
                 (imm_sel == 2'b10) ? {{(XLEN-12){instr[31]}}, instr[7]    , instr[30:25] , instr[11:8] ,1'b0}: // B type
                                      {{(XLEN-21){instr[31]}}, instr[19:12], instr[20]    , instr[30:21],1'b0} ; // J type
                                      
endmodule