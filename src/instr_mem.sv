import riscky_pkg::*;

module instr_mem(
    input logic rst_n, // rst is active low
    input logic [XLEN-1:0] addr,
    output logic [XLEN-1:0] rd_instr
);

logic [XLEN-1:0] imem [1023:0];

assign rd_instr = (!rst_n) ? {XLEN{1'b0}} : imem[addr];

endmodule