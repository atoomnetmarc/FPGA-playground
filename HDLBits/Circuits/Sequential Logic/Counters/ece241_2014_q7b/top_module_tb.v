/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1ms / 100us

module top_module_tb ();
  wire OneHertz;
  wire [2:0] c_enable;

  reg clk = 1'd1;
  reg reset = 1'd1;

  localparam ITERATIONS = 100000;

  always begin
    #0.5 clk = clk + 1;
  end

  always begin
    #49891 reset = reset + 1;
    #9 reset = reset + 1;
  end

  initial begin
    #0.5 reset = reset + 1;
  end

  top_module uut (
      .clk(clk),
      .reset(reset),
      .OneHertz(OneHertz),
      .c_enable(c_enable)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
