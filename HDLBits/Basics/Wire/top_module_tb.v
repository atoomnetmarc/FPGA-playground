/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();

  wire out;

  reg stim = 1'd0;

  localparam ITERATIONS = 16;

  always begin
    #1 stim = stim + 1;
  end

  top_module uut (
      .in(stim),
      .out(out)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
