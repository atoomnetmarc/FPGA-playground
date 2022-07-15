/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg clk = 1'd1;
  reg load = 1'd0;
  reg [9:0] data;
  wire tc;

  localparam ITERATIONS = 10000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #1;
    #10 data = 10'd3;
    load = 1'b1;
    #10 load = 1'b0;
    #100;
  end

  top_module uut (
      .clk(clk),
      .load(load),
      .data(data),
      .tc(tc)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
