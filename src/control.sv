import riscky_pkg::*;

module control(
    input [6:0] op, funct7,
    input [2:0] funct3,

    output reg_write, alu_src, mem_write, result_src, branch,
    output [1:0] imm_src,
    output [2:0] alu_control
);

logic [1:0] alu_op;

assign reg_write = (op == 7'b0000011 | op == 7'b0110011 | op == 7'b0010011) ? 1'b1 : 1'b0;
assign imm_src   = (op == 7'b0100011) ? 2'b01 : 
                   (op == 7'b1100011) ? 2'b10 :
                                        2'b00 ;
assign alu_src   = (op == 7'b0000011 | op == 7'b0100011 | op == 7'b0010011) ? 1'b1 : 1'b0;

assign mem_write = (op == 7'b0100011) ? 1'b1 : 1'b0;

assign result_src = (op == 7'b0000011) ? 1'b1 : 1'b0;

assign branch = (op == 7'b1100011) ? 1'b1 : 1'b0;

assign alu_op = (op == 7'b0110011) ? 2'b10 :  
                (op == 7'b1100011) ? 2'b01 :
                                     2'b00 ;

assign alu_control =    (alu_op == 2'b00) ? 3'b000 :
                        (alu_op == 2'b01) ? 3'b001 :
                        ((alu_op == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} == 2'b11)) ? 3'b001 : 
                        ((alu_op == 2'b10) & (funct3 == 3'b000) & ({op[5],funct7[5]} != 2'b11)) ? 3'b000 : 
                        ((alu_op == 2'b10) & (funct3 == 3'b010)) ? 3'b101 : 
                        ((alu_op == 2'b10) & (funct3 == 3'b110)) ? 3'b011 : 
                        ((alu_op == 2'b10) & (funct3 == 3'b111)) ? 3'b010 : 
                                                                   3'b000 ;
endmodule