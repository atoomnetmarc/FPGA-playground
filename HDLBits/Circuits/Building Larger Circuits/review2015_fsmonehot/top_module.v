/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input d,
    input done_counting,
    input ack,
    input [9:0] state,
    output B3_next,
    output S_next,
    output S1_next,
    output Count_next,
    output Wait_next,
    output done,
    output counting,
    output shift_ena
);

  parameter STATE_S = 4'd0;
  parameter STATE_S1 = 4'd1;
  parameter STATE_S11 = 4'd2;
  parameter STATE_S110 = 4'd3;
  parameter STATE_B0 = 4'd4;
  parameter STATE_B1 = 4'd5;
  parameter STATE_B2 = 4'd6;
  parameter STATE_B3 = 4'd7;
  parameter STATE_Count = 4'd8;
  parameter STATE_Wait = 4'd9;

  wire [9:0] next_state;
  assign B3_next = next_state[STATE_B3];
  assign S_next = next_state[STATE_S];
  assign S1_next = next_state[STATE_S1];
  assign Count_next = next_state[STATE_Count];
  assign Wait_next = next_state[STATE_Wait];

  //Determine next state.
  assign next_state[STATE_S] =
    state[STATE_S] & ~d |
    state[STATE_S1] & ~d |
    state[STATE_S110] & ~d |
    state[STATE_Wait] & ack;

  assign next_state[STATE_S1] = state[STATE_S] & d;
  assign next_state[STATE_S11] = state[STATE_S1] & d | state[STATE_S11] & d;
  assign next_state[STATE_S110] = state[STATE_S11] & ~d;
  assign next_state[STATE_B0] = state[STATE_S110] & d;
  assign next_state[STATE_B1] = state[STATE_B0];
  assign next_state[STATE_B2] = state[STATE_B1];
  assign next_state[STATE_B3] = state[STATE_B2];
  assign next_state[STATE_Count] = state[STATE_B3] | state[STATE_Count] & ~done_counting;
  assign next_state[STATE_Wait] = state[STATE_Count] & done_counting | state[STATE_Wait] & ~ack;

  //Determine output.
  assign shift_ena = state[STATE_B0] | state[STATE_B1] | state[STATE_B2] | state[STATE_B3];
  assign counting = state[STATE_Count];
  assign done = state[STATE_Wait];
endmodule
