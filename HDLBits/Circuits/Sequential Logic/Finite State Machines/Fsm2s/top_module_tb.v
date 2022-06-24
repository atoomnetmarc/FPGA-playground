/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  wire out;

  reg clk = 1'd1;
  reg reset = 1'd0;
  reg j = 1'd0;
  reg k = 1'd0;

  localparam ITERATIONS = 1000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #50 j = 1'b0;
    #50 j = 1'b1;
  end

  always begin
    #70 k = 1'b0;
    #70 k = 1'b1;
  end

  initial begin
    #220 reset = 1'b1;
    #20 reset = 1'b0;
  end

  top_module uut (
      .clk(clk),
      .reset(reset),
      .j(j),
      .k(k),
      .out(out)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
