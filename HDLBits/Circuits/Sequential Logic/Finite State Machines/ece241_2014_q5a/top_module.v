/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire areset,
    input  wire x,
    output reg  z
);

  parameter STATE_A = 2'b00;
  parameter STATE_B = 2'b01;
  parameter STATE_C = 2'b10;
  parameter STATE_ILLEGAL = 2'b11;

  reg [1:0] state, next_state = STATE_A;

  //Determine next state.
  always @(*) begin
    casez ({
      x, state
    })
      {1'b0, STATE_A} : next_state = STATE_A;
      {1'b1, STATE_A} : next_state = STATE_B;
      {1'b0, STATE_B} : next_state = STATE_B;
      {1'b1, STATE_B} : next_state = STATE_C;
      {1'b0, STATE_C} : next_state = STATE_B;
      {1'b1, STATE_C} : next_state = STATE_C;
      default: next_state = STATE_ILLEGAL;
    endcase
  end

  //State transition.
  always @(posedge clk, posedge areset) begin
    if (areset) state <= STATE_A;
    else if (clk) state <= next_state;
  end

  //Determine output.
  always @(*) begin
    case (state)
      STATE_A, STATE_C: z = 1'b0;
      STATE_B: z = 1'b1;
      default: z = 1'bx;
    endcase
  end

endmodule
