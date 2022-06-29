/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg clk = 1'd1;
  reg reset = 1'd0;
  reg [7:0] in = 1'd0;
  wire [23:0] out_bytes;
  wire done;

  reg [7:0] counter = 8'd0;

  localparam ITERATIONS = 1000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #10 counter = counter + 1'b1;
  end

  always begin
    #1;
    #10 in = counter;
    #10 in = counter;

    #10 in = counter | 8'h8;
    #10 in = counter;
    #10 in = counter;

    #10 in = counter | 8'h8;
    #10 in = counter;
    #10 in = counter;

    #10 in = counter | 8'h8;
    #9;
  end

  initial begin
    #80 reset = 1'b1;
    #5 reset = 1'b0;
  end

  top_module uut (
      .clk(clk),
      .in(in),
      .reset(reset),
      .out_bytes(out_bytes),
      .done(done)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
