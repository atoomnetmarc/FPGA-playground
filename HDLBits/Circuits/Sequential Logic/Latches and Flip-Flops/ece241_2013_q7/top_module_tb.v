/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  wire Q;

  reg  clk = 1'd0;
  reg  j = 1'd0;
  reg  k = 1'd0;

  localparam ITERATIONS = 60;

  always begin
    #1 clk = clk + 1;
  end

  always begin
    #3 j = j + 1;
  end

  always begin
    #5 k = k + 1;
  end

  top_module uut (
      .clk(clk),
      .j  (j),
      .k  (k),
      .Q  (Q)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
