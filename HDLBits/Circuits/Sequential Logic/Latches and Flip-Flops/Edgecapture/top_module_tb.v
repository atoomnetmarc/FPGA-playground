/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  wire [31:0] out;

  reg clk = 1'd1;
  reg reset = 1'd0;
  reg [31:0] in = 1'd0;

  localparam ITERATIONS = 300;

  always begin
    #1 clk = clk + 1;
  end

  always begin
    #2 in = in + 1;
  end

  always begin
    #48 reset = 1;
    #2 reset = 0;
  end


  top_module uut (
      .clk(clk),
      .reset(reset),
      .in(in),
      .out(out)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
