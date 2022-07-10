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
`define STATE_ILLEGAL 3'b111

module top_module (
    input  wire clk,
    input  wire reset,  // synchronous reset
    input  wire w,
    output reg  z
);

  reg [2:0] state = `STATE_A, next_state = `STATE_A;

  //Determine next state.
  always @(*) begin
    case ({
      w, state
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
      default: next_state = `STATE_ILLEGAL;
    endcase
  end

  //State transition.
  always @(posedge clk) begin
    if (reset) state <= `STATE_A;
    else if (clk) state <= next_state;
  end

  //Determine output.
  always @(*) begin
    case (state)
      `STATE_A, `STATE_B, `STATE_C, `STATE_D: z = 1'b0;
      `STATE_E, `STATE_F: z = 1'b1;
      default: z = 1'bx;
    endcase
  end

endmodule
