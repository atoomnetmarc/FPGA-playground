/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg  clk = 1'd1;
  reg  reset = 1'd0;
  reg  data = 1'd0;
  wire start_shifting;

  localparam ITERATIONS = 10000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #1;
    #105 reset = 1'b1;
    #15 reset = 1'b0;
    #10 data = 1'b1;
    #30 data = 1'b0;
    #10 data = 1'b1;
    #20 data = 1'b0;
    #20 data = 1'b1;
    #9;
  end

  top_module uut (
      .clk(clk),
      .reset(reset),
      .data(data),
      .start_shifting(start_shifting)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
