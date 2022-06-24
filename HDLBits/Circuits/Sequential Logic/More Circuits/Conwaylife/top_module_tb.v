/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  reg clk = 1'b1;
  reg load = 1'b0;
  reg [255:0] data;
  wire [255:0] q;

  localparam ITERATIONS = 1024;

  always begin
    #1 clk = clk + 1;
  end

  initial begin
    data = {
      16'b0000000000000000,
      16'b0000000000000000,
      16'b0000000000000000,
      16'b0000000000000000,
      16'b0000000000000000,
      16'b0000000000000000,
      16'b0000000000000000,
      16'b0000010000000000,
      16'b0000001000000000,
      16'b0000111000000000,
      16'b0000000000000000,
      16'b0000000000000000,
      16'b0000000000000000,
      16'b0100000000000000,
      16'b0100000000000000,
      16'b0100000000000000
      };
    #2 load = 1'b1;
    #1 load = 1'b0;
  end


  top_module uut (
      .clk(clk),
      .load(load),
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
