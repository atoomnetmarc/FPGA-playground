/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg  clk = 1'd1;
  reg  reset = 1'd1;
  reg  x = 1'd0;
  wire z;

  localparam ITERATIONS = 10000;

  initial begin
    #10 reset = 1'b0;
  end

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #10 x = $random;
  end

  top_module uut (
      .clk(clk),
      .reset(reset),
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
