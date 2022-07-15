/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg  clk = 1'd1;
  reg  reset = 1'd1;
  reg  data = 1'd0;
  wire shift_ena;
  wire counting;
  reg  done_counting = 1'd0;
  wire done;
  reg  ack = 1'd0;

  localparam ITERATIONS = 1000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #1;

    #10;
    reset = 1'b0;
    data  = 1'b1;

    #10;
    data = 1'b0;

    #10;

    #10;
    data = 1'b1;

    #10;

    #10;
    data = 1'b0;

    #10;
    data = 1'b1;

    #9;
  end

  top_module uut (
      .clk(clk),
      .reset(reset),
      .data(data),
      .shift_ena(shift_ena),
      .counting(counting),
      .done_counting(done_counting),
      .done(done),
      .ack(ack)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
