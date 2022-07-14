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

  parameter LEFT = 3'h0, RIGHT = 3'h1, FALL_L = 3'h2, FALL_R = 3'h3, DIGG_L = 3'h4, DIGG_R = 3'h5, SPLAT = 3'h6, FALL2FAST = 3'h7;
  reg [2:0] state = LEFT, next_state;

  parameter MAX_FALL_HEIGHT = 5'd20;
  reg [4:0] fallcounter = 5'h0;

  parameter GROUND_DIG = 2'b11;
  parameter GROUND_SOLID = 2'b10;
  parameter GROUND_SOLID_IGNORE_DIG = 2'b1z;
  parameter GROUND_ABSENT = 2'b0z;
  parameter GROUND_IGNORE = 2'bzz;
  parameter BUMP_BOTH = 2'b11;
  parameter BUMP_LEFT = 2'b10;
  parameter BUMP_RIGHT = 2'b01;
  parameter BUMP_IGNORE = 2'bzz;

  parameter VOICE_AAAAAH = 1'b1;
  parameter VOICE_SILENT = 1'b0;
  parameter ACTION_DIGGING = 1'b1;
  parameter ACTION_NOTDIGGIN = 1'b0;

  //Determine next state.
  always @(*) begin
    casez ({
      bump_left, bump_right, ground, dig, state, (fallcounter > MAX_FALL_HEIGHT)
    })
      {BUMP_BOTH, GROUND_SOLID, LEFT, 1'b0} :                   next_state = RIGHT;
      {BUMP_BOTH, GROUND_SOLID, RIGHT, 1'b0} :                  next_state = LEFT;
      {BUMP_LEFT, GROUND_SOLID, LEFT, 1'b0} :                   next_state = RIGHT;
      {BUMP_RIGHT, GROUND_SOLID, RIGHT, 1'b0} :                 next_state = LEFT;
      {BUMP_IGNORE, GROUND_ABSENT, LEFT, 1'b0} :                next_state = FALL_L;
      {BUMP_IGNORE, GROUND_ABSENT, RIGHT, 1'b0} :               next_state = FALL_R;
      {BUMP_IGNORE, GROUND_SOLID_IGNORE_DIG, FALL_L, 1'b0} :    next_state = LEFT;
      {BUMP_IGNORE, GROUND_SOLID_IGNORE_DIG, FALL_R, 1'b0} :    next_state = RIGHT;
      {BUMP_IGNORE, GROUND_SOLID_IGNORE_DIG, FALL_L, 1'b1} :    next_state = SPLAT;
      {BUMP_IGNORE, GROUND_SOLID_IGNORE_DIG, FALL_R, 1'b1} :    next_state = SPLAT;
      {BUMP_IGNORE, GROUND_IGNORE, FALL_L, 1'b1} :              next_state = FALL2FAST;
      {BUMP_IGNORE, GROUND_IGNORE, FALL_R, 1'b1} :              next_state = FALL2FAST;
      {BUMP_IGNORE, GROUND_SOLID_IGNORE_DIG, FALL2FAST, 1'b1} : next_state = SPLAT;
      {BUMP_IGNORE, GROUND_DIG, LEFT, 1'b0} :                   next_state = DIGG_L;
      {BUMP_IGNORE, GROUND_DIG, RIGHT, 1'b0} :                  next_state = DIGG_R;
      {BUMP_IGNORE, GROUND_ABSENT, DIGG_L, 1'b0} :              next_state = FALL_L;
      {BUMP_IGNORE, GROUND_ABSENT, DIGG_R, 1'b0} :              next_state = FALL_R;
      default:                                                  next_state = state;
    endcase
  end

  //State transition.
  always @(posedge clk, posedge areset) begin
    if (areset) begin
      state <= LEFT;
      fallcounter <= 5'h0;
    end else if (clk) begin
      state <= next_state;

      case (next_state)
        FALL_L, FALL_R, FALL2FAST, SPLAT:
        if (fallcounter <= MAX_FALL_HEIGHT) fallcounter = fallcounter + 1'b1;
        default: fallcounter <= 5'h0;
      endcase

    end
  end

  //Determine output.
  always @(*) begin
    case (state)
      LEFT: {walk_left, walk_right, aaah, digging} = {2'b10, VOICE_SILENT, ACTION_NOTDIGGIN};
      RIGHT: {walk_left, walk_right, aaah, digging} = {2'b01, VOICE_SILENT, ACTION_NOTDIGGIN};
      FALL_L, FALL_R, FALL2FAST:
      {walk_left, walk_right, aaah, digging} = {2'b00, VOICE_AAAAAH, ACTION_NOTDIGGIN};
      DIGG_L, DIGG_R:
      {walk_left, walk_right, aaah, digging} = {2'b00, VOICE_SILENT, ACTION_DIGGING};
      default: {walk_left, walk_right, aaah, digging} = {2'b00, VOICE_SILENT, ACTION_NOTDIGGIN};
    endcase
  end
endmodule
