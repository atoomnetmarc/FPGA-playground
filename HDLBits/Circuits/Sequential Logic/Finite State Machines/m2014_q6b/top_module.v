/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

`define STATE_A 3'b000
`define STATE_B 3'b001
`define STATE_C 3'b010
`define STATE_D 3'b011
`define STATE_E 3'b100
`define STATE_F 3'b101

module top_module (
    input wire [3:1] y,
    input wire w,
    output wire Y2
);

  reg [3:1] next_state;

  assign Y2 = next_state[2];

  //Determine next state.
  always @(*) begin
    case ({
      w, y
    })
      {1'b0, `STATE_A} : next_state = `STATE_B;
      {1'b1, `STATE_A} : next_state = `STATE_A;
      {1'b0, `STATE_B} : next_state = `STATE_C;
      {1'b1, `STATE_B} : next_state = `STATE_D;
      {1'b0, `STATE_C} : next_state = `STATE_E;
      {1'b1, `STATE_C} : next_state = `STATE_D;
      {1'b0, `STATE_D} : next_state = `STATE_F;
      {1'b1, `STATE_D} : next_state = `STATE_A;
      {1'b0, `STATE_E} : next_state = `STATE_E;
      {1'b1, `STATE_E} : next_state = `STATE_D;
      {1'b0, `STATE_F} : next_state = `STATE_C;
      {1'b1, `STATE_F} : next_state = `STATE_D;
      default: next_state = `STATE_A;
    endcase
  end

endmodule
