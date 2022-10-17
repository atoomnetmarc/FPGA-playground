/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg clk = 1'd1;
  reg areset = 1'd0;
  reg train_valid = 1'd0;
  reg train_taken = 1'd0;
  wire [1:0] state;

  localparam ITERATIONS = 10000;

  always begin
    #5 clk = clk + 1;
  end

  initial begin
    #61 areset = 1'b1;
    #63 areset = 1'b0;
  end

  initial begin
    #50 train_valid = 1'b1;
  end

  always begin
    #5 train_taken = $random;
  end

  top_module uut (
      .clk(clk),
      .areset(areset),
      .train_valid(train_valid),
      .train_taken(train_taken),
      .state(state)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
