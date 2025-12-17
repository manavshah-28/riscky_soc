import riscky_pkg::*;

module mux(
    input logic [XLEN-1:0] A,B,
    input logic sel,
    output logic [XLEN-1:0] mux_out
);

assign mux_out = (sel) ? B : A;

endmodule