/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

`define STATE_S0 4'd0
`define STATE_S1 4'd1
`define STATE_S2 4'd2
`define STATE_S3 4'd3
`define STATE_S4 4'd4
`define STATE_S5 4'd5
`define STATE_S6 4'd6
`define STATE_S7 4'd7
`define STATE_S8 4'd8
`define STATE_S9 4'd9

module top_module (
    input wire in,
    input wire [9:0] state,
    output wire [9:0] next_state,
    output wire out1,
    output wire out2
);

  //Determine next state.
  assign next_state[`STATE_S0] =
    state[`STATE_S0] & ~in |
    state[`STATE_S1] & ~in |
    state[`STATE_S2] & ~in |
    state[`STATE_S3] & ~in |
    state[`STATE_S4] & ~in |
    state[`STATE_S7] & ~in |
    state[`STATE_S8] & ~in |
    state[`STATE_S9] & ~in;

  assign next_state[`STATE_S1] =
    state[`STATE_S0] & in |
    state[`STATE_S8] & in |
    state[`STATE_S9] & in;

  assign next_state[`STATE_S2] = state[`STATE_S1] & in;
  assign next_state[`STATE_S3] = state[`STATE_S2] & in;
  assign next_state[`STATE_S4] = state[`STATE_S3] & in;
  assign next_state[`STATE_S5] = state[`STATE_S4] & in;
  assign next_state[`STATE_S6] = state[`STATE_S5] & in;
  assign next_state[`STATE_S7] = state[`STATE_S6] & in | state[`STATE_S7] & in;
  assign next_state[`STATE_S8] = state[`STATE_S5] & ~in;
  assign next_state[`STATE_S9] = state[`STATE_S6] & ~in;

  //Determine output.
  assign out1 = state[`STATE_S8] | state[`STATE_S9];
  assign out2 = state[`STATE_S7] | state[`STATE_S9];
endmodule
