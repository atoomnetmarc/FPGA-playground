/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg clk = 1'd1;
  reg resetn = 1'd1;
  reg [3:1] r = 1'd0;
  wire [3:1] g;

  localparam ITERATIONS = 10000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #10 r = $random;
  end

  always begin
    #100 resetn = 1'b0;
    #10 resetn = 1'b1;
  end

  top_module uut (
      .clk(clk),
      .resetn(resetn),
      .r(r),
      .g(g)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
