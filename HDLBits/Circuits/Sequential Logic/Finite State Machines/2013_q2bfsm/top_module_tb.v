/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg  clk = 1'd1;
  reg  resetn;
  reg  x = 1'd0;
  reg  y = 1'd0;
  wire f;
  wire g;

  localparam ITERATIONS = 10000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #10 x = $random;
    y = $random;
  end

  always begin
    resetn = 1'b0;
    #10 resetn = 1'b1;
    #90;
  end

  top_module uut (
      .clk(clk),
      .resetn(resetn),
      .x(x),
      .y(y),
      .f(f),
      .g(g)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
