/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  wire [3:0] q;

  reg clk = 1'd1;
  reg reset = 1'd0;

  localparam ITERATIONS = 300;

  always begin
    #1 clk = clk + 1;
  end

  always begin
    #40 reset = reset + 1;
    #1  reset = reset + 1;
  end


  top_module uut (
      .clk(clk),
      .reset(reset),
      .q(q)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
