/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  reg clk = 1'd0;
  reg areset = 1'd0;
  reg load = 1'd0;
  reg ena = 1'd0;
  reg [3:0] data;
  wire [3:0] q;

  localparam ITERATIONS = 300;

  always begin
    #1 clk = clk + 1;
  end

  always begin
    #9 ena = 1;
    #1 ena = 0;
  end

  initial begin
    #2.4 areset = 1;
    #0.2 areset = 0;
  end

  initial begin
    #18 data = 4'b1111;
    #1 load = 1;
    #1 load = 0;
  end

  top_module uut (
      .clk(clk),
      .areset(areset),
      .load(load),
      .ena(ena),
      .data(data),
      .q(q)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
