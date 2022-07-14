/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire reset,
    input  wire x,
    output reg  z
);

  parameter STATE_000 = 3'b000;
  parameter STATE_001 = 3'b001;
  parameter STATE_010 = 3'b010;
  parameter STATE_011 = 3'b011;
  parameter STATE_100 = 3'b100;
  parameter STATE_ILLEGAL = 3'b111;

  reg [2:0] state = STATE_000, next_state = STATE_000;

  //Determine next state.
  always @(*) begin
    casez ({
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
      default: next_state = STATE_ILLEGAL;
    endcase

  end

  //State transition.
  always @(posedge clk) begin
    if (reset) state <= STATE_000;
    else if (clk) state <= next_state;
  end

  //Determine output.
  always @(*) begin
    case (state)
      STATE_000, STATE_001, STATE_010: z = 1'b0;
      STATE_011, STATE_100: z = 1'b1;
      default: z = 1'bx;
    endcase
  end
endmodule
