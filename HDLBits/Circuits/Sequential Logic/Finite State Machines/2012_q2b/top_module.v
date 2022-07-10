/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

`define STATE_A 3'd0
`define STATE_B 3'd1
`define STATE_C 3'd2
`define STATE_D 3'd3
`define STATE_E 3'd4
`define STATE_F 3'd5

module top_module (
    input wire [5:0] y,
    input wire w,
    output wire Y1,
    output wire Y3
);

  wire [5:0] state, next_state;
  assign state = y;
  assign Y1 = next_state[1];
  assign Y3 = next_state[3];

  //Determine next state.
  assign next_state[`STATE_A] =
    state[`STATE_A] & ~w |
    state[`STATE_D] & ~w;

  assign next_state[`STATE_B] =
    state[`STATE_A] & w;

  assign next_state[`STATE_C] =
    state[`STATE_B] & w |
    state[`STATE_F] & w;

  assign next_state[`STATE_D] =
    state[`STATE_B] & ~w |
    state[`STATE_C] & ~w |
    state[`STATE_E] & ~w |
    state[`STATE_F] & ~w;

  assign next_state[`STATE_E] =
    state[`STATE_E] & w |
    state[`STATE_C] & w;

  assign next_state[`STATE_F] =
    state[`STATE_D] & w;

endmodule
