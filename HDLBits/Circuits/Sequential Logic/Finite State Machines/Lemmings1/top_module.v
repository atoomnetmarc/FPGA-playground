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
    output reg  walk_left,
    output reg  walk_right
);

  parameter LEFT = 1'd0, RIGHT = 1'd1;
  reg state, next_state;

  //Determine next state.
  always @(*) begin
    casez ({
      bump_left, bump_right, state
    })
      {2'b11, LEFT} : next_state = RIGHT;
      {2'b11, RIGHT} : next_state = LEFT;
      {2'b10, LEFT} : next_state = RIGHT;
      {2'b01, RIGHT} : next_state = LEFT;
      default:  next_state = state;
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
      LEFT: {walk_left, walk_right} = 2'b10;
      RIGHT: {walk_left, walk_right} = 2'b01;
      default: {walk_left, walk_right} = 2'b00;
    endcase
  end
endmodule
