/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg clk = 1'd1;
  reg reset = 1'd1;
  reg in = 1'd1;
  wire [7:0] out_byte;
  wire done;
  reg [1:0] fase;

  parameter FASE_WEIRD = 2'd0;
  parameter FASE_VALID_PARITY = 2'd1;
  parameter FASE_INVALID_PARITY = 2'd2;
  parameter FASE_RANDOM = 2'd3;


  localparam ITERATIONS = 1000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    //Weird bits
    #10 in = 1'b0;
    fase = FASE_WEIRD;
    #90 in = 1'b1;
    #10 in = 1'b0;
    #90 in = 1'b1;
    #10 in = 1'b0;
    #100;

    //Valid parity
    #10 in = 1'b1;  //idle
    fase = FASE_VALID_PARITY;
    #30 in = 1'b0;  //start
    #10 in = 1'b1;  //bit 1
    #10 in = 1'b1;  //bit 2
    #10 in = 1'b0;  //bit 3
    #10 in = 1'b1;  //bit 4
    #10 in = 1'b0;  //bit 5
    #10 in = 1'b0;  //bit 6
    #10 in = 1'b1;  //bit 7
    #10 in = 1'b0;  //bit 8
    #10 in = 1'b1;  //parity
    #10 in = 1'b1;  //stop

    //Invalid parity
    #10 in = 1'b1;  //idle
    fase = FASE_INVALID_PARITY;
    #30 in = 1'b0;  //start
    #10 in = 1'b0;  //bit 1
    #10 in = 1'b1;  //bit 2
    #10 in = 1'b0;  //bit 3
    #10 in = 1'b0;  //bit 4
    #10 in = 1'b0;  //bit 5
    #10 in = 1'b1;  //bit 6
    #10 in = 1'b1;  //bit 7
    #10 in = 1'b0;  //bit 8
    #10 in = 1'b1;  //parity
    #10 in = 1'b1;  //stop

    //Crap
    #10 in = 1'b1;  //idle
    fase = FASE_RANDOM;
    #30 in = 1'b0;  //start
    #10 in = $random;  //bit 1
    #10 in = $random;  //bit 2
    #10 in = $random;  //bit 3
    #10 in = $random;  //bit 4
    #10 in = $random;  //bit 5
    #10 in = $random;  //bit 6
    #10 in = $random;  //bit 7
    #10 in = $random;  //bit 8
    #10 in = $random;  //parity
    #10 in = 1'b0;  //invalid stop
  end

  initial begin
    #10 reset = 1'b0;
  end

  top_module uut (
      .clk(clk),
      .reset(reset),
      .in(in),
      .out_byte(out_byte),
      .done(done)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
