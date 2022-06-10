/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();

  wire [2:0] out_or_bitwise;
  wire out_or_logical;
  wire [5:0] out_not;

  reg [2:0] stim_a = 2'd0;
  reg [2:0] stim_b = 2'd0;

  localparam ITERATIONS = 32;

  always begin
    #1 stim_a = stim_a + 1;
  end

  always begin
    #2 stim_b = stim_b + 1;
  end

  top_module uut (
      .a(stim_a),
      .b(stim_b),
      .out_or_bitwise(out_or_bitwise),
      .out_or_logical(out_or_logical),
      .out_not(out_not)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
