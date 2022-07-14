/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none


module top_module (
    input wire clk,
    input wire resetn,
    input wire [3:1] r,
    output reg [3:1] g
);

  parameter STATE_A = 3'b000;
  parameter STATE_B = 3'b001;
  parameter STATE_C = 3'b010;
  parameter STATE_D = 3'b011;
  parameter STATE_ILLEGAL = 3'b111;

  reg [2:0] state = STATE_A, next_state = STATE_A;

  //Determine next state.
  always @(*) begin
    casez ({
      r, state
    })
      {3'b000, STATE_A} : next_state = STATE_A;
      {3'bzz1, STATE_A} : next_state = STATE_B;
      {3'bz10, STATE_A} : next_state = STATE_C;
      {3'b100, STATE_A} : next_state = STATE_D;
      {3'bzz1, STATE_B} : next_state = STATE_B;
      {3'bzz0, STATE_B} : next_state = STATE_A;
      {3'bz1z, STATE_C} : next_state = STATE_C;
      {3'bz0z, STATE_C} : next_state = STATE_A;
      {3'b1zz, STATE_D} : next_state = STATE_D;
      {3'b0zz, STATE_D} : next_state = STATE_A;
      default: next_state = STATE_ILLEGAL;
    endcase
  end

  //State transition.
  always @(posedge clk) begin
    if (~resetn) state <= STATE_A;
    else if (clk) state <= next_state;
  end

  //Determine output.
  always @(*) begin
    case (state)
      STATE_A: g = 3'b000;
      STATE_B: g = 3'b001;
      STATE_C: g = 3'b010;
      STATE_D: g = 3'b100;
      default: g = 3'bxxx;
    endcase
  end

endmodule
