import riscky_pkg::*;

module fetch(
    input clk, rst_n, pc_src_e,
    input [XLEN-1:0] pc_target_e,
    output [ILEN-1:0] instr_d,
    output [XLEN-1:0] pc_d, pc_plus4_d
);

//wires 
logic [XLEN-1:0] pc_;
logic [XLEN-1:0] pcf

// regs
logic [XLEN-1:0] instr_reg_f;       // fetch stage instruction reg
logic [XLEN-1:0] pc_reg_f;          // fetch stage pc reg
logic [XLEN-1:0] pc_plus4_reg_f;    // fetch stage pc4 reg

mux pc_mux(
    .A(pc_plus4_f),
    .B(pc_target_e),
    .sel(pc_src_e),
    .mux_out(pc_)
);

pc program_counter(
    .clk(),
    .rst_n(),
    .pc_next(),
    .pc()
);

adder pc_adder(
    .a(),
    .b(),
    .c()
);

instr_mem instruction_memory(
    .rst_n(),
    .addr(),
    .rd_instr()
);

always @(posedge clk) begin
if(!rst_n) begin
pc_reg_f <= 'b0;
end
else begin
pc_reg_f <= pc_;
end
end
endmodule