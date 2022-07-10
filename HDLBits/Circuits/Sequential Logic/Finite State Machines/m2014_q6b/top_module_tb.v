/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg [3:1] y;
  reg  w = 1'd0;
  wire Y2;

  localparam ITERATIONS = 10000;

  always begin
    #10 w = $random;
    y = $random;
  end

  top_module uut (
      .y(y),
      .w(w),
      .Y2(Y2)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
