/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg in = 1'd0;
  reg [9:0] state = 10'd0;

  wire out1;
  wire out2;
  wire [9:0] next_state;

  always begin
    #10 state = next_state;
  end

  initial begin
    #1 state = 10'b0000000001;
  end

  initial begin
    //State from S0 to S7 to S7 to S0
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b0;

    //State from S0 to S8 to S0;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b0;
    #10 in = 1'b0;

    //State from S0 to S8 to S1 to S0;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b0;
    #10 in = 1'b1;
    #10 in = 1'b0;

    //State from S0 to S9 to S0;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b0;
    #10 in = 1'b0;

    //State from S0 to S9 to to S1 to S0;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b1;
    #10 in = 1'b0;
    #10 in = 1'b1;
    #10 in = 1'b0;

    #20
    $finish;
  end

  top_module uut (
      .in(in),
      .state(state),
      .next_state(next_state),
      .out1(out1),
      .out2(out2)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);
  end

endmodule
