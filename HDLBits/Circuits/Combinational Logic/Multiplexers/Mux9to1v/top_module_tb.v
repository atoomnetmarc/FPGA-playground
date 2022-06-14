/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();

  reg [15:0] a = 16'd0;
  reg [15:0] b = 16'd1;
  reg [15:0] c = 16'd2;
  reg [15:0] d = 16'd4;
  reg [15:0] e = 16'd8;
  reg [15:0] f = 16'd16;
  reg [15:0] g = 16'd32;
  reg [15:0] h = 16'd64;
  reg [15:0] i = 16'd128;
  reg [3:0] sel = 3'd0;

  wire [15:0] out;

  localparam ITERATIONS = 20;

  always begin
    #1 sel = sel + 1;
  end

  top_module uut (
      .a  (a),
      .b  (b),
      .c  (c),
      .d  (d),
      .e  (e),
      .f  (f),
      .g  (g),
      .h  (h),
      .i  (i),
      .sel(sel),
      .out(out)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
