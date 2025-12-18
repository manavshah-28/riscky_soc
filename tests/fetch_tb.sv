import riscky_pkg::*;

class fetch_txn;

rand bit [XLEN-1:0] pc_target_e;
rand bit pc_src_e;

constraint c_target {
    pc_target_e inside {[0:60]};
    pc_target_e % 4 == 0;
}

constraint c_src{
    pc_src_e dist {0:= 75, 1 := 25};
}
endclass

module fetch_tb();

// signal declarations
logic clk, rst_n;
logic pc_src_e;
logic [XLEN-1:0] pc_target_e;
logic [ILEN-1:0] instr_d;
logic [XLEN-1:0] pc_d, pc_plus4_d;

// dut instantiation
fetch dut (.*);

// class 
fetch_txn f1;

initial begin
clk = 0;
forever begin
#5 clk = ~clk;
end
end

initial begin

rst_n = 0;
#10  rst_n = 1;

f1 = new();

repeat(10) begin
f1.randomize();
pc_target_e = f1.pc_target_e;
pc_src_e = f1.pc_src_e;

@(posedge clk);   // allow PC to update
$display("pc_target_e = %0d, pc_src_e = %0b, pc_d = %0d, pc_plus4_d = %0d, instr_f = %0h, instr_d = %0h", f1.pc_target_e, f1.pc_src_e, pc_d, pc_plus4_d, dut.instr_f,instr_d);
end
$finish;
end


endmodule