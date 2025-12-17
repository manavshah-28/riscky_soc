import riscky_pkg::*;

class mux_txn;
  rand logic [XLEN-1:0] A;
  rand logic [XLEN-1:0] B;
  rand logic sel;

  function void post_randomize();
    $display("TXN: A=%0d B=%0d sel=%0b", A, B, sel);
  endfunction
endclass


module mux_tb;

  // DUT signals
  logic [XLEN-1:0] A;
  logic [XLEN-1:0] B;
  logic            sel;
  logic [XLEN-1:0] mux_out;

  // DUT instantiation
  mux dut (
    .A(A),
    .B(B),
    .sel(sel),
    .mux_out(mux_out)
  );

  // Transaction handle
  mux_txn transaction;

  initial begin
    transaction = new();

    repeat (10) begin
      assert(transaction.randomize());

      // Drive DUT
      A   = transaction.A;
      B   = transaction.B;
      sel = transaction.sel;

      #10;
      $display("DUT: A=%0d B=%0d sel=%0b OUT=%0d",
               A, B, sel, mux_out);
    end

    $finish;
  end

endmodule
