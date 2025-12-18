import riscky_pkg::*;

class reg_txn;
rand bit [4:0] A1, A2, A3;
rand bit we;
rand bit [XLEN-1:0] D3;

constraint c_we {
    we dist {0:= 55, 1 := 45};
}

constraint c_d3{
    D3 inside {[0:100]};
}

endclass

module reg_file_tb();

// signal declarations
logic clk;
logic rst_n;
logic we;
logic [XLEN-1:0] D3;
logic [4:0] A1,A2,A3;
logic [XLEN-1:0] RD1, RD2;

// dut instantiation
register_file dut(.*);
reg_txn txn;

initial begin
clk = 0;
forever #5 clk = ~clk;
end


initial begin

    txn = new();

    rst_n = 0;
    #10;
    rst_n = 1;

    #10;

    repeat(30) begin
        txn.randomize();

        we = txn.we;
        A1 = txn.A1;
        A2 = txn.A2;
        A3 = txn.A3;
        D3 = txn.D3;

        @(posedge clk);

        $display("we = %0b, A1 = %0d, A2 = %0d, A3 = %0d, D3 = %0d, RD1 = %0d, RD2 = %0d", we, A1, A2, A3, D3, RD1, RD2);

    end
    $finish;
end


endmodule