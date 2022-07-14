/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire areset,
    input  wire bump_left,
    input  wire bump_right,
    input  wire ground,
    output reg  walk_left,
    output reg  walk_right,
    output reg  aaah
);

  parameter LEFT = 2'b00, RIGHT = 2'b01, FALL_L = 2'b10, FALL_R = 2'b11;
  reg [1:0] state = LEFT, next_state;

  parameter GROUND_SOLID =1'b1;
  parameter GROUND_ABSENT =1'b0;
  parameter VOICE_AAAAAH =1'b1;
  parameter VOICE_SILENT =1'b0;

  //Determine next state.
  always @(*) begin
    casez ({
      bump_left, bump_right, ground, state
    })
      {2'b11, GROUND_SOLID, LEFT} : next_state = RIGHT;
      {2'b11, GROUND_SOLID, RIGHT} : next_state = LEFT;
      {2'b10, GROUND_SOLID, LEFT} : next_state = RIGHT;
      {2'b01, GROUND_SOLID, RIGHT} : next_state = LEFT;
      {2'bzz, GROUND_ABSENT, LEFT} : next_state = FALL_L;
      {2'bzz, GROUND_ABSENT, RIGHT} : next_state = FALL_R;
      {2'bzz, GROUND_SOLID, FALL_L} : next_state = LEFT;
      {2'bzz, GROUND_SOLID, FALL_R} : next_state = RIGHT;
      default: next_state = state;
    endcase
  end

  //State transition.
  always @(posedge clk, posedge areset) begin
    if (areset) state <= LEFT;
    else if (clk) begin
      state <= next_state;
    end
  end

  //Determine output.
  always @(*) begin
    case (state)
      LEFT: {walk_left, walk_right, aaah} = {2'b10, VOICE_SILENT};
      RIGHT: {walk_left, walk_right, aaah} = {2'b01, VOICE_SILENT};
      FALL_L, FALL_R: {walk_left, walk_right, aaah} = {2'b00, VOICE_AAAAAH};
      default: {walk_left, walk_right, aaah} = {2'b00, VOICE_SILENT};
    endcase
  end
endmodule
