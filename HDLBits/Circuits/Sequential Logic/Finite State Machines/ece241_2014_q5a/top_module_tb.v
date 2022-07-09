/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg  clk = 1'd1;
  reg  areset = 1'd0;
  reg  x = 1'd0;
  wire z;

  localparam ITERATIONS = 10000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #100 areset = 1'b1;
    #10 areset = 1'b0;
    #20 x = 1'b1;
    #10 x = 1'b0;
    #10 x = 1'b1;
    #20 x = 1'b0;
  end

  top_module uut (
      .clk(clk),
      .areset(areset),
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
