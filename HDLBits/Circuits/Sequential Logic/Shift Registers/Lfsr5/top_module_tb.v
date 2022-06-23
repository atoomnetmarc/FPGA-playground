/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  reg clk = 1'd1;
  reg reset = 1'd0;
  wire [4:0] q;

  localparam ITERATIONS = 300;

  always begin
    #1 clk = clk + 1;
  end

  initial begin
    #2 reset = 1;
    #1 reset = 0;
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
