import riscky_pkg::*;

module register_file(
    input clk,
    input rst_n,
    input we,
    input [XLEN-1:0] D3,
    input [4:0] A1,A2,A3,
    output [XLEN-1:0] RD1,RD2
);

// registers x0 to x31.
// x0 register is always 0.

logic [XLEN-1:0] reg_file [XLEN-1:0];

always @(posedge clk) begin
    if(we & (A3 != 5'h00))
    reg_file[A3] <= D3;
end

assign RD1 = (!rst_n) ? 64'b0 : reg_file[A1];
assign RD2 = (!rst_n) ? 64'b0 : reg_file[A2];

// initialization of reg file
initial begin
    foreach (reg_file[i]) begin
        reg_file[i] = 'b0;
    end
end

endmodule