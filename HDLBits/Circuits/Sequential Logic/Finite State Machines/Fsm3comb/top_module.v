/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire in,
    input wire [1:0] state,
    output reg [1:0] next_state,
    output reg out
);

  parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

  //Determine next state.
  always @(*) begin
    casez ({
      in, state
    })
      {1'b0, A} : next_state = A;
      {1'b1, A} : next_state = B;
      {1'b0, B} : next_state = C;
      {1'b1, B} : next_state = B;
      {1'b0, C} : next_state = A;
      {1'b1, C} : next_state = D;
      {1'b0, D} : next_state = C;
      {1'b1, D} : next_state = B;
      default: next_state = B;
    endcase
  end

  //Determine output.
  always @(*) begin
    case (state)
      D: out = 1'b1;
      default: out = 1'b0;
    endcase
  end

endmodule
