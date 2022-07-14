/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire resetn,
    input  wire x,
    input  wire y,
    output reg  f,
    output reg  g
);

  parameter STATE_A = 4'b0000;
  parameter STATE_F = 4'b0001;
  parameter STATE_X0 = 4'b0010;
  parameter STATE_X1 = 4'b0011;
  parameter STATE_X2 = 4'b0100;
  parameter STATE_G = 4'b0101;
  parameter STATE_Y1 = 4'b0110;
  parameter STATE_GP0 = 4'b0111;
  parameter STATE_GP1 = 4'b1000;
  parameter STATE_ILLEGAL = 4'b1111;

  reg [3:0] state = STATE_A, next_state = STATE_A;

  //Determine next state.
  always @(*) begin
    casez ({
      {x, y}, state
    })
      {2'bzz, STATE_A} : next_state = STATE_F;
      {2'bzz, STATE_F} : next_state = STATE_X0;
      {2'b0z, STATE_X0} : next_state = STATE_X0;
      {2'b1z, STATE_X0} : next_state = STATE_X1;
      {2'b0z, STATE_X1} : next_state = STATE_X2;
      {2'b1z, STATE_X1} : next_state = STATE_X1;
      {2'b0z, STATE_X2} : next_state = STATE_X0;
      {2'b1z, STATE_X2} : next_state = STATE_G;
      {2'bz0, STATE_G} : next_state = STATE_Y1;
      {2'bz1, STATE_G} : next_state = STATE_GP1;
      {2'bz0, STATE_Y1} : next_state = STATE_GP0;
      {2'bz1, STATE_Y1} : next_state = STATE_GP1;
      {2'bzz, STATE_GP0} : next_state = STATE_GP0;
      {2'bzz, STATE_GP1} : next_state = STATE_GP1;
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
      STATE_A, STATE_X0, STATE_X1, STATE_X2, STATE_GP0: {f, g} = 2'b00;
      STATE_F: {f, g} = 2'b10;
      STATE_G, STATE_Y1, STATE_GP1: {f, g} = 2'b01;
      default: {f, g} = 2'bxx;
    endcase
  end
endmodule
