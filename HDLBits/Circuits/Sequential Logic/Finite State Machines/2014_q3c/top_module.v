/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire [2:0] y,
    input wire x,
    output wire Y0,
    output reg z
);

  parameter STATE_000 = 3'b000;
  parameter STATE_001 = 3'b001;
  parameter STATE_010 = 3'b010;
  parameter STATE_011 = 3'b011;
  parameter STATE_100 = 3'b100;

  wire [2:0] state;
  reg  [2:0] next_state;

  assign state = y;
  assign Y0 = next_state[0];

  //Determine next state.
  always @(*) begin
    case ({
      x, state
    })
      {1'b0, STATE_000} : next_state = STATE_000;
      {1'b1, STATE_000} : next_state = STATE_001;
      {1'b0, STATE_001} : next_state = STATE_001;
      {1'b1, STATE_001} : next_state = STATE_100;
      {1'b0, STATE_010} : next_state = STATE_010;
      {1'b1, STATE_010} : next_state = STATE_001;
      {1'b0, STATE_011} : next_state = STATE_001;
      {1'b1, STATE_011} : next_state = STATE_010;
      {1'b0, STATE_100} : next_state = STATE_011;
      {1'b1, STATE_100} : next_state = STATE_100;
      default: next_state = STATE_000;
    endcase
  end

  //Determine output.
  always @(*) begin
    case (state)
      STATE_011, STATE_100: z = 1'b1;
      default: z = 1'b0;
    endcase
  end
endmodule
