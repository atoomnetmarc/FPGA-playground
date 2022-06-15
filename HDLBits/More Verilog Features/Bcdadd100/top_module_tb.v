/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();

  wire [399:0] sum;

  reg [399:0] stim_a = 400'h1234567890123456789012345678901234567890;
  reg [399:0] stim_b = 400'h1234567890123456789012345678901234567890;

  localparam ITERATIONS = 8;

  always begin
    #1 stim_a = stim_a + 1;
    stim_b = stim_b + 1;
  end

  top_module uut (
      .a(stim_a),
      .b(stim_b),
      .cin(1'b0),
      .sum(sum),
      .cout()
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
