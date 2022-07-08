/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg  clk = 1'd1;
  reg  aresetn = 1'd1;
  reg  x = 1'd1;
  wire z;
  wire z_wanted;

  localparam ITERATIONS = 10000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #0.1;
    #90 x = 1'b0;
    #30 x = 1'b1;
    #10 x = 1'b0;
    #10 x = 1'b1;
    #10 x = 1'b0;
    #10 x = 1'b1;
    #20 x = 1'b0;
    #10 x = 1'b1;
    #40;

    #10 x = $random;
    #10 x = $random;
    #10 x = $random;
    #10 x = $random;
    #10 x = $random;
    #10 x = $random;
    #10 x = $random;
    #10 x = $random;
    #10 x = $random;
    #10 x = $random;
    #9.9;
  end

  always begin
    #101 aresetn = 1'b0;
    #0.1 aresetn = 1'b1;
  end

  top_module uut (
      .clk(clk),
      .aresetn(aresetn),
      .x(x),
      .z(z)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
