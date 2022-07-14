/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire reset,
    input  wire in,
    output reg  disc,
    output reg  flag,
    output reg  err
);

  parameter STATE_NONE = 4'b0000;
  parameter STATE_ONE = 4'b0001;
  parameter STATE_TWO = 4'b0010;
  parameter STATE_THREE = 4'b0011;
  parameter STATE_FOUR = 4'b0100;
  parameter STATE_FIVE = 4'b0101;
  parameter STATE_SIX = 4'b0110;
  parameter STATE_ERROR = 4'b0111;
  parameter STATE_DISCARD = 4'b1000;
  parameter STATE_FLAG = 4'b1001;
  parameter STATE_ILLIGAL = 4'b1111;

  reg [3:0] state = STATE_NONE, next_state = STATE_NONE;

  //Determine next state.
  always @(*) begin
    casez ({
      in, state
    })
      {1'b0, STATE_NONE} :    next_state = STATE_NONE;
      {1'b0, STATE_ONE} :     next_state = STATE_NONE;
      {1'b0, STATE_TWO} :     next_state = STATE_NONE;
      {1'b0, STATE_THREE} :   next_state = STATE_NONE;
      {1'b0, STATE_FOUR} :    next_state = STATE_NONE;
      {1'b0, STATE_ERROR} :   next_state = STATE_NONE;
      {1'b0, STATE_DISCARD} : next_state = STATE_NONE;
      {1'b0, STATE_FLAG} :    next_state = STATE_NONE;

      {1'b1, STATE_NONE} :    next_state = STATE_ONE;
      {1'b1, STATE_DISCARD} : next_state = STATE_ONE;
      {1'b1, STATE_FLAG} :    next_state = STATE_ONE;

      {1'b1, STATE_ONE} :   next_state = STATE_TWO;
      {1'b1, STATE_TWO} :   next_state = STATE_THREE;
      {1'b1, STATE_THREE} : next_state = STATE_FOUR;
      {1'b1, STATE_FOUR} :  next_state = STATE_FIVE;
      {1'b1, STATE_FIVE} :  next_state = STATE_SIX;
      {1'b0, STATE_FIVE} :  next_state = STATE_DISCARD;
      {1'b0, STATE_SIX} :   next_state = STATE_FLAG;

      {1'b1, STATE_SIX} :   next_state = STATE_ERROR;
      {1'b1, STATE_ERROR} : next_state = STATE_ERROR;

      //We forgot a state.
      {1'bz, STATE_ILLIGAL} : next_state = STATE_ILLIGAL;
      default: next_state = STATE_ILLIGAL;
    endcase
  end

  //State transition.
  always @(posedge clk) begin
    if (reset) state <= STATE_NONE;
    else if (clk) begin
      state <= next_state;
    end
  end

  //Determine output.
  always @(*) begin
    case (state)
      STATE_DISCARD: {disc, flag, err} = 3'b100;
      STATE_FLAG:    {disc, flag, err} = 3'b010;
      STATE_ERROR:   {disc, flag, err} = 3'b001;
      default:       {disc, flag, err} = 3'b000;
    endcase
  end
endmodule
