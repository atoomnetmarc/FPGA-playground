/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  wire [3:0] Q;
  wire c_enable;
  wire c_load;
  wire [3:0] c_d;

  reg clk = 1'd1;
  reg reset = 1'd0;
  reg enable = 1'd0;

  localparam ITERATIONS = 300;

  always begin
    #1 clk = clk + 1;
  end

  always begin
    #20 enable = enable + 1;
  end

  always begin
    #98 reset = reset + 1;
    #2 reset = reset + 1;
  end


  top_module uut (
      .clk(clk),
      .reset(reset),
      .enable(enable),
      .Q(Q),
      .c_enable(c_enable),
      .c_load(c_load),
      .c_d(c_d)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
