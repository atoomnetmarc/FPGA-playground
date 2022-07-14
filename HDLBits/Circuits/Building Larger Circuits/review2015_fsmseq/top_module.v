/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire reset,
    input  wire data,
    output reg  start_shifting
);

  parameter STATE_X0 = 3'b000;
  parameter STATE_X1 = 3'b001;
  parameter STATE_X2 = 3'b010;
  parameter STATE_X3 = 3'b011;
  parameter STATE_F0 = 3'b100;
  parameter STATE_ILLEGAL = 3'b111;

  reg [2:0] state = STATE_X0, next_state = STATE_X0;

  //Determine next state.
  always @(*) begin
    casez ({
      data, state
    })
      {1'b0, STATE_X0} : next_state = STATE_X0;
      {1'b1, STATE_X0} : next_state = STATE_X1;
      {1'b0, STATE_X1} : next_state = STATE_X0;
      {1'b1, STATE_X1} : next_state = STATE_X2;
      {1'b0, STATE_X2} : next_state = STATE_X3;
      {1'b1, STATE_X2} : next_state = STATE_X2;
      {1'b0, STATE_X3} : next_state = STATE_X0;
      {1'b1, STATE_X3} : next_state = STATE_F0;
      {1'bz, STATE_F0} : next_state = STATE_F0;
      default: next_state = STATE_ILLEGAL;
    endcase
  end

  //State transition.
  always @(posedge clk) begin
    if (reset) state <= STATE_X0;
    else if (clk) state <= next_state;
  end

  //Determine output.
  always @(*) begin
    case (state)
      STATE_X0, STATE_X1, STATE_X2, STATE_X3: start_shifting = 1'b0;
      STATE_F0: start_shifting = 1'b1;
      default: start_shifting = 1'bx;
    endcase
  end

endmodule
