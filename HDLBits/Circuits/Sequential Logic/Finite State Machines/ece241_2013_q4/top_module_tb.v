/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  wire fr3;
  wire fr2;
  wire fr1;
  wire dfr;

  reg clk = 1'd1;
  reg reset = 1'd0;
  reg [3:1] s = 1'd1;

  localparam ITERATIONS = 1000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #10 s = 3'b000;
    #10 s = 3'b001;
    #10 s = 3'b011;
    #10 s = 3'b111;
    #10;
    #10 s = 3'b011;
    #10 s = 3'b001;
    #10 s = 3'b000;
    #50;
  end

  initial begin
    #300 reset = 1'b1;
    #10 reset = 1'b0;
  end

  top_module uut (
      .clk(clk),
      .s(s),
      .fr3(fr3),
      .fr2(fr2),
      .fr1(fr1),
      .dfr(dfr)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
