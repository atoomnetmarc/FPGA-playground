/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg  clk = 1'd1;
  reg  reset = 1'd1;
  wire shift_ena;

  localparam ITERATIONS = 100;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #1;
    #10 reset = 1'b0;
    #9;
  end

  top_module uut (
      .clk(clk),
      .reset(reset),
      .shift_ena(shift_ena)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
