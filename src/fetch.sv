import riscky_pkg::*;

module fetch(
    input clk, rst_n, pc_src_e,
    input [XLEN-1:0] pc_target_e,
    output logic [ILEN-1:0] instr_d,
    output logic [XLEN-1:0] pc_d, pc_plus4_d
);

//wires 
logic [ILEN-1:0] instr_f;
logic [XLEN-1:0] pcf_, pcf;
logic [XLEN-1:0] pc_plus4_f;

// regs
logic [XLEN-1:0] pcf_reg;      
logic [ILEN-1:0] pc_plus4_f_reg;          
logic [XLEN-1:0] instr_f_reg;    // fetch stage pc4 reg

mux pc_mux(
    .A(pc_plus4_f),
    .B(pc_target_e),
    .sel(pc_src_e),
    .mux_out(pcf_)
);

pc program_counter(
    .clk(clk),
    .rst_n(rst_n),
    .pc_next(pcf_),
    .pc(pcf)
);

adder pc_adder(
    .a(pcf),
    .b(64'h00000004),
    .c(pc_plus4_f)
);

instr_mem instruction_memory(
    .rst_n(rst_n),
    .addr(pcf),
    .rd_instr(instr_f)
);

always @(posedge clk) begin
if(!rst_n) begin
    pcf_reg <= 'b0;
    pc_plus4_f_reg <= 'b0;
    instr_f_reg <= 'b0;
end
else begin
    pcf_reg <= pcf;
    pc_plus4_f_reg <= pc_plus4_f;
    instr_f_reg <= instr_f;
end
end

// output ports
assign instr_d = (!rst_n) ? 64'b0 : instr_f_reg; 
assign pc_d =  (!rst_n) ? 64'b0 : pcf_reg;
assign pc_plus4_d = (!rst_n) ? 64'b0 : pc_plus4_f_reg;

endmodule