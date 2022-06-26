/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire in,
    input  wire areset,
    output reg  out
);

  parameter A = 2'h0, B = 2'h1, C = 2'h2, D = 2'h3;
  reg [1:0] state, next_state;

  //Determine next state.
  always @(*) begin
    case ({
      in, state
    })
      {1'b0, A} : next_state = A;
      {1'b0, B} : next_state = C;
      {1'b0, C} : next_state = A;
      {1'b1, C} : next_state = D;
      {1'b0, D} : next_state = C;
      default: next_state = B;
    endcase
  end

  //State transition.
  always @(posedge clk, posedge areset) begin
    if (areset) state <= A;
    else if (clk) begin
      state <= next_state;
    end
  end

  //Determine output.
  always @(*) begin
    case (state)
      D: out = 1'b1;
      default: out = 1'b0;
    endcase
  end
endmodule
