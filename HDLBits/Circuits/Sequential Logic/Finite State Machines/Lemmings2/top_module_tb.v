/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  wire walk_left;
  wire walk_right;
  wire aaah;

  reg clk = 1'd1;
  reg areset = 1'd0;
  reg bump_left = 1'd0;
  reg bump_right = 1'd0;
  reg ground = 1'd1;

  localparam ITERATIONS = 1000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #10 bump_left = 1'b1;
    #10 bump_left = 1'b0;
    #50;
    #10 bump_left = 1'b1;
    bump_right = 1'b1;
    #50 bump_left = 1'b0;
    bump_right = 1'b0;
    #50;
    #10 bump_right = 1'b1;
    #10 bump_right = 1'b0;
    #50;
  end

  always begin
    #125 ground = 1'b0;
    #125 ground = 1'b1;
  end

  initial begin
    #57 areset = 1'b1;
    #1 areset = 1'b0;
  end

  top_module uut (
      .clk(clk),
      .areset(areset),
      .bump_left(bump_left),
      .bump_right(bump_right),
      .ground(ground),
      .walk_left(walk_left),
      .walk_right(walk_right),
      .aaah(aaah)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
