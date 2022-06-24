/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  wire out;

  reg clk = 1'd1;
  reg reset = 1'd0;
  reg in = 1'd1;

  localparam ITERATIONS = 1000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #100 in = 1'b0;
    #30 in = 1'b1;
  end

  initial begin
    #110 reset = 1'b1;
    #10 reset = 1'b0;
  end

  top_module uut (
      .clk(clk),
      .reset(reset),
      .in(in),
      .out(out)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
