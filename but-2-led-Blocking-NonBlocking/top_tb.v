/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1ns / 10ps

module top_tb ();

  wire LED1;
  wire LED2;

  reg  CLK = 0;
  reg  BUT1 = 0;

  localparam ITERATIONS = 100;

  always begin
    #1 CLK = ~CLK;
  end

  always begin
    #2 BUT1 = 1'b0;
    #8 BUT1 = 1'b1;
  end

  top uut (
      .CLK (CLK),
      .BUT1(BUT1),
      .LED1(LED1),
      .LED2(LED2)
  );

  initial begin
    $dumpfile("top_tb.vcd");
    $dumpvars(0, top_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
