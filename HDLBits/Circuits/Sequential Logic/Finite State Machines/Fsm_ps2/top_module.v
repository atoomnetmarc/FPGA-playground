/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire [7:0] in,
    input wire reset,
    output reg done
);

  parameter STATE_BYTE1 = 2'b00;
  parameter STATE_BYTE2 = 2'b01;
  parameter STATE_BYTE3 = 2'b10;
  parameter STATE_DONE = 2'b11;

  reg [1:0] state, next_state = STATE_BYTE1;

  //Determine next state.
  always @(*) begin
    casez ({
      in[3], state
    })
      {1'b0, STATE_BYTE1} : next_state = STATE_BYTE1;
      {1'b1, STATE_BYTE1} : next_state = STATE_BYTE2;
      {1'bz, STATE_BYTE2} : next_state = STATE_BYTE3;
      {1'bz, STATE_BYTE3} : next_state = STATE_DONE;
      {1'b0, STATE_DONE} : next_state = STATE_BYTE1;
      {1'b1, STATE_DONE} : next_state = STATE_BYTE2;
      default: next_state = state;
    endcase
  end

  //State transition.
  always @(posedge clk) begin
    if (reset) state <= STATE_BYTE1;
    else if (clk) begin
      state <= next_state;
    end
  end

  //Determine output.
  always @(*) begin
    case (state)
      STATE_DONE: done = 1'b1;
      default: done = 1'b0;
    endcase
  end
endmodule
