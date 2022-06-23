/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  reg clk = 1'b1;
  reg enable = 1'b0;
  reg in = 1'b0;
  reg [2:0] select = 3'b0;
  wire out;

  localparam ITERATIONS = 300;

  always begin
    in = $random;
    #1 clk = clk + 1;
  end

  initial begin
    #30 enable = 1'b1;
    #30 enable = 1'b0;
  end

  initial begin
    #70 select = select + 1;
    #0.5 select = select + 1;
    #0.5 select = select + 1;
    #0.5 select = select + 1;
    #0.5 select = select + 1;
    #0.5 select = select + 1;
    #0.5 select = select + 1;
    #0.5 select = select + 1;
    #0.5 select = select + 1;
  end

  top_module uut (
      .clk(clk),
      .enable(enable),
      .S(in),
      .A(select[2]),
      .B(select[1]),
      .C(select[0]),
      .Z(out)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
