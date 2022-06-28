/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  wire [3:0] activity;
  wire aaah;

  reg clk = 1'd1;
  reg areset = 1'd0;
  reg bump_left = 1'd0;
  reg bump_right = 1'd0;
  reg ground = 1'd1;
  reg dig = 1'd0;

  localparam ITERATIONS = 2000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #20 dig = 1'b1;
    #10 dig = 1'b0;
    #10 bump_left = 1'b1;
    #10 bump_left = 1'b0;
    #10 ground = 1'b0;
    #30 ground = 1'b1;
    dig = 1'b1;
    #10 dig = 1'b0;
    #50;
    #10 bump_right = 1'b1;
    #10 bump_right = 1'b0;
    #50;
    #10 ground = 1'b0;
    #200 ground = 1'b1;
    #50;
    #10 ground = 1'b0;
    #210 ground = 1'b1;
    #50;
    #10 ground = 1'b0;
    #300 ground = 1'b1;
  end

  initial begin
    #72 areset = 1'b1;
    #1 areset = 1'b0;
  end

  initial begin
    #892 areset = 1'b1;
    #1 areset = 1'b0;
  end

  top_module uut (
      .clk(clk),
      .areset(areset),
      .bump_left(bump_left),
      .bump_right(bump_right),
      .ground(ground),
      .dig(dig),
      .walk_left(activity[1]),
      .walk_right(activity[0]),
      .aaah(activity[2]),
      .digging(activity[3])
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
