/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire reset,
    input  wire data,
    output reg  shift_ena,
    output reg  counting,
    input  wire done_counting,
    output reg  done,
    input  wire ack
);

  parameter STATE_S = 4'h0;
  parameter STATE_S1 = 4'h1;
  parameter STATE_S11 = 4'h2;
  parameter STATE_S110 = 4'h3;
  parameter STATE_B0 = 4'h4;
  parameter STATE_B1 = 4'h5;
  parameter STATE_B2 = 4'h6;
  parameter STATE_B3 = 4'h7;
  parameter STATE_Count = 4'h8;
  parameter STATE_Wait = 4'h9;
  parameter STATE_ILLEGAL = 4'hF;

  reg [3:0] state = STATE_S, next_state = STATE_S;
  reg [3:0] q = 4'b0;

  //Determine next state.
  always @(*) begin
    casez ({
      data, done_counting, ack, state
    })
      {3'b0zz, STATE_S} : next_state = STATE_S;
      {3'b1zz, STATE_S} : next_state = STATE_S1;
      {3'b0zz, STATE_S1} : next_state = STATE_S;
      {3'b1zz, STATE_S1} : next_state = STATE_S11;
      {3'b0zz, STATE_S11} : next_state = STATE_S110;
      {3'b1zz, STATE_S11} : next_state = STATE_S11;
      {3'b0zz, STATE_S110} : next_state = STATE_S;
      {3'b1zz, STATE_S110} : next_state = STATE_B0;
      {3'bzzz, STATE_B0} : next_state = STATE_B1;
      {3'bzzz, STATE_B1} : next_state = STATE_B2;
      {3'bzzz, STATE_B2} : next_state = STATE_B3;
      {3'bzzz, STATE_B3} : next_state = STATE_Count;
      {3'bz0z, STATE_Count} : next_state = STATE_Count;
      {3'bz1z, STATE_Count} : next_state = STATE_Wait;
      {3'bzz0, STATE_Wait} : next_state = STATE_Wait;
      {3'bzz1, STATE_Wait} : next_state = STATE_S;
      default: next_state = STATE_ILLEGAL;
    endcase
  end

  //State transition.
  always @(posedge clk) begin
    if (reset) state <= STATE_S;
    else if (clk) state <= next_state;

    if (shift_ena) q <= {q[2:0], data};
    if (counting) q <= q - 1'b1;
  end

  //Determine output.
  always @(*) begin
    case (state)
      STATE_S, STATE_S1, STATE_S11, STATE_S110: {shift_ena, counting, done} = 3'b000;
      STATE_B0, STATE_B1, STATE_B2, STATE_B3: {shift_ena, counting, done} = 3'b100;
      STATE_Count: {shift_ena, counting, done} = 3'b010;
      STATE_Wait: {shift_ena, counting, done} = 3'b001;
      default: {shift_ena, counting, done} = 3'bxxx;
    endcase
  end

endmodule
