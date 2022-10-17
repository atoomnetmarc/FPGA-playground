/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire areset,
    input wire train_valid,
    input wire train_taken,
    output reg [1:0] state
);

  parameter STATE_SNT = 2'b00;
  parameter STATE_WNT = 2'b01;
  parameter STATE_WT = 2'b10;
  parameter STATE_ST = 2'b11;

  reg [1:0] next_state;

  //Determine next state.
  always @(*) begin
    casez ({
      train_valid, train_taken, state
    })
      {2'b0z, 2'bzz} : next_state = state;
      {2'b10, STATE_SNT} : next_state = STATE_SNT;
      {2'b10, STATE_WNT} : next_state = STATE_SNT;
      {2'b10, STATE_WT} : next_state = STATE_WNT;
      {2'b10, STATE_ST} : next_state = STATE_WT;
      {2'b11, STATE_SNT} : next_state = STATE_WNT;
      {2'b11, STATE_WNT} : next_state = STATE_WT;
      {2'b11, STATE_WT} : next_state = STATE_ST;
      {2'b11, STATE_ST} : next_state = STATE_ST;
      default: next_state = STATE_WNT;
    endcase
  end

  //State transition.
  always @(posedge clk, posedge areset) begin
    if (areset) state <= STATE_WNT;
    else if (clk) state <= next_state;
  end
endmodule
