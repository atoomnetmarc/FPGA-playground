/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg  clk = 1'd1;
  reg [2:0] y;
  reg  x = 1'd0;
  wire Y0;
  wire z;

  localparam ITERATIONS = 10000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #10 x = $random;
    y = $random;
  end

  top_module uut (
      .clk(clk),
      .y(y),
      .x(x),
      .Y0(Y0),
      .z(z)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
