/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();

  wire [31:0] sum;

  reg [31:0] stim_a = 32'd1000;
  reg [31:0] stim_b = 32'd100;
  reg sub = 1'b0;

  localparam ITERATIONS = 60;

  always begin
    #1 stim_a = $random;
    #1 stim_b = $random;
    #2 sub = $random;
  end

  top_module uut (
      .a(stim_a),
      .b(stim_b),
      .sub(sub),
      .sum(sum)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
