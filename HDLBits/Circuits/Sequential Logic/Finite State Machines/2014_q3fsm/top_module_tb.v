/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg  clk = 1'd1;
  reg  reset = 1'd1;
  reg  s = 1'd0;
  reg  w = 1'd0;
  wire z;

  localparam ITERATIONS = 10000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #1;
    #20 reset = 1'b0;
    #20 s = 1'b1;

    #10 w = 1'b1;
    #30 w = 1'b0;
    #5 w = 1'b1;
    #10 w = 1'b0;
    #5 w = 1'b1;
    #10 w = 1'b0;
    #5 w = 1'b1;
    #5 w = 1'b0;
    #5 w = 1'b1;
    #5 w = 1'b0;
    #5 w = 1'b1;
    #10 w = 1'b0;
    #9;
  end

  top_module uut (
      .clk(clk),
      .reset(reset),
      .s(s),
      .w(w),
      .z(z)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
