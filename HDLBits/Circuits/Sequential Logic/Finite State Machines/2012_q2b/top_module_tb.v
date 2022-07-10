/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg [5:0] y;
  reg  w = 1'd0;
  wire Y1;
  wire Y3;

  localparam ITERATIONS = 10000;

  always begin
    #10 w = $random;
    y = 1 << ($urandom%6);
  end

  top_module uut (
      .y(y),
      .w(w),
      .Y1(Y1),
      .Y3(Y3)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
