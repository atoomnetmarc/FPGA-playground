/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg clk = 1'd1;
  reg shift_ena = 1'd0;
  reg count_ena = 1'd0;
  reg data = 1'd0;
  wire [3:0] q;

  localparam ITERATIONS = 10000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #1;
    #10 shift_ena = 1'b1;
    data = $random;
    #10 data = $random;
    #10 data = $random;
    #10 data = $random;
    #10 shift_ena = 1'b0;
    #100;
    #10 count_ena = 1'b1;
    #200 count_ena = 1'b0;
    #9;
  end

  top_module uut (
      .clk(clk),
      .shift_ena(shift_ena),
      .count_ena(count_ena),
      .data(data),
      .q(q)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
