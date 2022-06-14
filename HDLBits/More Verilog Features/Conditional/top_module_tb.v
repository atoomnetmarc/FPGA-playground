/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();

  wire [7:0] min;

  reg [7:0] a = 8'd0;
  reg [7:0] b = 8'd0;
  reg [7:0] c = 8'd0;
  reg [7:0] d = 8'd0;

  localparam ITERATIONS = 60;

  always begin
    #1 a = $random;
    b = $random;
    c = $random;
    d = $random;
  end

  top_module uut (
      .a(a),
      .b(b),
      .c(c),
      .d(d),
      .min(min)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
