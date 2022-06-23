/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  reg clk = 1'd1;
  reg load = 1'd0;
  reg [2:0] data;
  wire [2:0] q;

  localparam ITERATIONS = 300;

  always begin
    #1 clk = clk + 1;
  end

  initial begin
    #19 data = 3'h5;
    #1 load = 1;
    #1 load = 0;
  end


  top_module uut (
      .SW(data),
      .KEY({load, clk}),
      .LEDR(q)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
