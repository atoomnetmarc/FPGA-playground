/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg [6:1] y;
  reg  w = 1'd0;
  wire Y2;
  wire Y4;

  localparam ITERATIONS = 10000;

  always begin
    #10 w = $random;
    y = 1 << ($urandom%6);
  end

  top_module uut (
      .y(y),
      .w(w),
      .Y2(Y2),
      .Y4(Y4)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
