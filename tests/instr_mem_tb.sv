import riscky_pkg::*;

class instr_txn;

rand logic [XLEN-1:0] addr;
rand logic rst_n; 
rand logic [XLEN-1:0] instr;

    constraint addr_range {
        addr inside {[0:100]};
    }

    constraint c_rst_dist {
        rst_n dist { 0 := 30, 1 := 70};
    }

endclass

module instr_mem_tb;

// DUT signals
logic rst_n;
logic [XLEN-1:0] addr;
logic [XLEN-1:0] rd_instr;

// instantiation
instr_mem dut(
    .rst_n(rst_n),
    .addr(addr),
    .rd_instr(rd_instr)
);

// handle 
instr_txn transaction;

initial begin

transaction = new();

    // Fill instruction memory
    repeat (100) begin
        assert(transaction.randomize());

        // WRITE into DUT memory
        dut.imem[transaction.addr] = transaction.instr;
    end

    repeat (40) begin
    assert(transaction.randomize());

    // drive dut
    rst_n = transaction.rst_n;
    addr = transaction.addr;

    #10;
    $display("rst_n = %0b, addr = %0d, rd_instr = %0d", rst_n, addr, rd_instr);

    end
$finish;

end

endmodule
