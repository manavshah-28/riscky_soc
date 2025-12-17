import riscky_pkg::*;

module adder(
    input logic [XLEN-1:0] a,
    input logic [XLEN-1:0] b,
    output logic [XLEN-1:0] c
);

assign c = a + b;

endmodule