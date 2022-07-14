/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire reset,
    input  wire s,
    input  wire w,
    output reg  z
);

  parameter STATE_A = 2'b00;
  parameter STATE_B = 2'b01;
  parameter STATE_C = 2'b10;
  parameter STATE_ILLEGAL = 2'b11;

  reg [1:0] state = STATE_A, next_state = STATE_A;
  reg [1:0] cyclecounter = 2'b0, next_cyclecounter = 2'b0;
  reg [1:0] bitcounter = 2'b0, next_bitcounter = 2'b0;
  reg flag = 1'b0;

  //Determine next state.
  always @(*) begin
    casez ({
      s, state
    })
      {1'b0, STATE_A} : next_state = STATE_A;
      {1'b1, STATE_A} : next_state = STATE_B;
      {1'bz, STATE_B} : next_state = STATE_C;
      {1'bz, STATE_C} : next_state = STATE_C;

      default: next_state = STATE_ILLEGAL;
    endcase

    if (state == STATE_C) begin
      //Keep track of the 3 clock cycle interval.
      if (cyclecounter == 2'b10) next_cyclecounter = 2'b0;
      else next_cyclecounter = cyclecounter + 2'b1;

      //Raise flag when on cycle 3 and counted 2 bits.
      if (cyclecounter == 2'b10 && bitcounter == 2'b10) flag = 1'b1;
      else flag = 1'b0;
    end else begin
      //Not in correct state.
      next_cyclecounter = 2'b0;
      flag = 1'b0;
    end

    if (state == STATE_B || state == STATE_C) begin
      //Keep track of bits during the 3 clock interval.
      if (next_cyclecounter == 2'b0) next_bitcounter = w;
      else next_bitcounter = bitcounter + w;
    end else next_bitcounter = 2'b0;

  end

  //State transition.
  always @(posedge clk) begin
    if (reset) begin
      state <= STATE_A;
    end else if (clk) begin
      state <= next_state;
      cyclecounter <= next_cyclecounter;
      bitcounter <= next_bitcounter;
    end
  end

  //Determine output.
  always @(*) begin
    z = flag;
  end
endmodule
