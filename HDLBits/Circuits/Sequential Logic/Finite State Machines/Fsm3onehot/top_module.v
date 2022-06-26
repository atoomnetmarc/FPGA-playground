/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire in,
    input wire [3:0] state,
    output wire [3:0] next_state,
    output wire out
);

  parameter A = 2'h0, B = 2'h1, C = 2'h2, D = 2'h3;

  //Determine next state.
  assign next_state[A] = state[A] & ~in | state[C] & ~in;
  assign next_state[B] = state[A] & in | state[B] & in | state[D] & in;
  assign next_state[C] = state[B] & ~in | state[D] & ~in;
  assign next_state[D] = state[C] & in;

  //Determine output.
  assign out = state[D];
endmodule
