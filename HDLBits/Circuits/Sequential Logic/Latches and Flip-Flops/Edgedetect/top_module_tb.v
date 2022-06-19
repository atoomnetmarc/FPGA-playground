/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  wire [7:0] pedge;

  reg clk = 1'd1;
  reg [7:0] in = 1'd0;

  localparam ITERATIONS = 300;

  always begin
    #1 clk = clk + 1;
  end

  always begin
    #2 in = in + 1;
  end

  top_module uut (
      .clk(clk),
      .in(in),
      .pedge(pedge)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
