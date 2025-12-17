import riscky_pkg::*;

module pc(
    input clk,
    input rst_n,
    input [XLEN-1:0] pc_next, 
    output logic [XLEN-1:0] pc
);

always @(posedge clk)begin

if(!rst_n) pc <= 'b0;

else begin
pc <= pc_next;
end

end

endmodule