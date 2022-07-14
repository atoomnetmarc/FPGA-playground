/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire areset,
    input  wire x,
    output wire z
);

  parameter STATE_A = 1'b0;
  parameter STATE_B = 1'b1;

  reg  [1:0] state;
  wire [1:0] next_state;

  //Determine next state.
  assign next_state[STATE_A] = state[STATE_A] & ~x;
  assign next_state[STATE_B] = state[STATE_A] & x | state[STATE_B];

  //State transition.
  always @(posedge clk, posedge areset) begin
    if (areset) state <= (1'b1 << STATE_A);
    else if (clk) state <= next_state;
  end

  //Determine output.
  assign z = state[STATE_A] & x | state[STATE_B] & ~x;
endmodule
