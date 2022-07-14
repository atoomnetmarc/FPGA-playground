/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire reset,
    output reg  shift_ena
);

  parameter STATE_C1 = 3'b001;
  parameter STATE_C2 = 3'b010;
  parameter STATE_C3 = 3'b011;
  parameter STATE_C4 = 3'b100;
  parameter STATE_OFF = 3'b101;
  parameter STATE_ILLEGAL = 3'b111;

  reg [2:0] state = STATE_C1, next_state = STATE_C1;

  //Determine next state.
  always @(*) begin
    case (state)
      STATE_C1: next_state = STATE_C2;
      STATE_C2: next_state = STATE_C3;
      STATE_C3: next_state = STATE_C4;
      STATE_C4: next_state = STATE_OFF;
      STATE_OFF: next_state = STATE_OFF;
      default: next_state = STATE_ILLEGAL;
    endcase
  end

  //State transition.
  always @(posedge clk) begin
    if (reset) state <= STATE_C1;
    else if (clk) state <= next_state;
  end

  //Determine output.
  always @(*) begin
    case (state)
      STATE_OFF: shift_ena = 1'b0;
      STATE_C1, STATE_C2, STATE_C3, STATE_C4: shift_ena = 1'b1;
      default: shift_ena = 1'bx;
    endcase
  end

endmodule
