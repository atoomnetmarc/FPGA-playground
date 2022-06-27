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
    input  wire dig,
    output reg  walk_left,
    output reg  walk_right,
    output reg  aaah,
    output reg  digging
);

  parameter LEFT = 3'h0, RIGHT = 3'h1, FALL_L = 3'h2, FALL_R = 3'h3, DIGG_L = 3'h4, DIGG_R = 3'h5;
  reg [2:0] state = LEFT, next_state;

  `define GROUND_DIG 2'b11
  `define GROUND_SOLID 2'b10
  `define GROUND_SOLID_WHILE_FALLING 2'b1z
  `define GROUND_ABSENT 2'b0z
  `define BUMP_BOTH 2'b11
  `define BUMP_LEFT 2'b10
  `define BUMP_RIGHT 2'b01
  `define BUMP_IGNORE 2'bzz

  `define VOICE_AAAAAH 1'b1
  `define VOICE_SILENT 1'b0
  `define ACTION_DIGGING 1'b1
  `define ACTION_NOTDIGGIN 1'b0

  //Determine next state.
  always @(*) begin
    casez ({
      bump_left, bump_right, ground, dig, state
    })
      {`BUMP_BOTH, `GROUND_SOLID, LEFT} :                   next_state = RIGHT;
      {`BUMP_BOTH, `GROUND_SOLID, RIGHT} :                  next_state = LEFT;
      {`BUMP_LEFT, `GROUND_SOLID, LEFT} :                   next_state = RIGHT;
      {`BUMP_RIGHT, `GROUND_SOLID, RIGHT} :                 next_state = LEFT;
      {`BUMP_IGNORE, `GROUND_ABSENT, LEFT} :                next_state = FALL_L;
      {`BUMP_IGNORE, `GROUND_ABSENT, RIGHT} :               next_state = FALL_R;
      {`BUMP_IGNORE, `GROUND_SOLID_WHILE_FALLING, FALL_L} : next_state = LEFT;
      {`BUMP_IGNORE, `GROUND_SOLID_WHILE_FALLING, FALL_R} : next_state = RIGHT;
      {`BUMP_IGNORE, `GROUND_DIG, LEFT} :                   next_state = DIGG_L;
      {`BUMP_IGNORE, `GROUND_DIG, RIGHT} :                  next_state = DIGG_R;
      {`BUMP_IGNORE, `GROUND_ABSENT, DIGG_L} :              next_state = FALL_L;
      {`BUMP_IGNORE, `GROUND_ABSENT, DIGG_R} :              next_state = FALL_R;
      default:                                              next_state = state;
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
      LEFT: {walk_left, walk_right, aaah, digging} = {2'b10, `VOICE_SILENT, `ACTION_NOTDIGGIN};
      RIGHT: {walk_left, walk_right, aaah, digging} = {2'b01, `VOICE_SILENT, `ACTION_NOTDIGGIN};
      FALL_L, FALL_R:
      {walk_left, walk_right, aaah, digging} = {2'b00, `VOICE_AAAAAH, `ACTION_NOTDIGGIN};
      DIGG_L, DIGG_R:
      {walk_left, walk_right, aaah, digging} = {2'b00, `VOICE_SILENT, `ACTION_DIGGING};
      default: {walk_left, walk_right, aaah, digging} = {2'b00, `VOICE_SILENT, `ACTION_NOTDIGGIN};
    endcase
  end
endmodule
