/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  wire pm;
  wire [7:0] hh;
  wire [7:0] mm;
  wire [7:0] ss;

  reg clk = 1'd1;
  reg reset = 1'd1;
  reg ena = 1'd0;

  localparam ITERATIONS = 100000;

  always begin
    #0.1 clk = clk + 1;
  end

  always begin
    #0.05 ena = 1'b0;
    #0.95 ena = 1'b1;
  end

  always begin
    #0.1 reset = 1'b0;
    #90999.9 reset = 1'b1;
  end

  top_module uut (
      .clk(clk),
      .reset(reset),
      .ena(ena),
      .pm(pm),
      .hh(hh),
      .mm(mm),
      .ss(ss)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
