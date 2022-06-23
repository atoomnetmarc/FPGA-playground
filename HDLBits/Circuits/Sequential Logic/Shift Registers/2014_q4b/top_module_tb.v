/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  reg clk = 1'b1;
  reg load = 1'b0;
  reg enable = 1'b0;
  reg in = 1'b0;
  reg [3:0] data;
  wire [3:0] q;

  localparam ITERATIONS = 300;

  always begin
    in = $random;
    #1 clk = clk + 1;
  end

  initial begin
    #19 data = 3'h5;
    #1 load = 1;
    #1 load = 0;
  end

  initial begin
    #30 enable = 1'b1;
  end

  top_module uut (
      .SW(data),
      .KEY({in, load, enable, clk}),
      .LEDR(q)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
