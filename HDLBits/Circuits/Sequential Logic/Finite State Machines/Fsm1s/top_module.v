/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire reset,
    input  wire in,
    output reg  out
);

  parameter A = 1'b0, B = 1'b1;
  reg state, next_state;

  //Determine next state.
  always @(*) begin
    case ({
      in, state
    })
      {1'b0, B} : next_state = A;
      {1'b1, A} : next_state = A;
      default: next_state = B;
    endcase
  end

  //State transition.
  always @(posedge clk) begin
    if (reset) state <= B;
    else if (clk) begin
      state <= next_state;
    end
  end

  //Determine output.
  always @(*) begin
    case (state)
      A: out = 1'b0;
      default: out = 1'b1;
    endcase
  end

endmodule
