/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();

  wire [1:0] pos;

  reg [3:0] in = 32'd0;

  localparam ITERATIONS = 60;

  always begin
    #1 in = $random;
  end

  top_module uut (
      .in(in),
      .pos(pos)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
