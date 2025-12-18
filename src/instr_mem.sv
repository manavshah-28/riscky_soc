import riscky_pkg::*;

module instr_mem(
    input logic rst_n, // rst is active low
    input  logic [IMEM_AW-1:0]     addr,       // word index
    output logic [ILEN-1:0]        rd_instr
);

logic [ILEN-1:0] imem [0:IMEM_WORDS-1];

assign rd_instr = (!rst_n) ? {ILEN{1'b0}} : imem[addr];

// initial begin
//     $readmemh("memfile.hex",imem);
// end

//test purposes
initial begin
imem[0]=32'h002082B3;
imem[4]=32'h005182B3;
imem[8]=32'h005202B3;
end

endmodule