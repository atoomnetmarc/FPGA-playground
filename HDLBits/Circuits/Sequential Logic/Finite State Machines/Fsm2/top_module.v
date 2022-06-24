/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire areset,
    input  wire j,
    input  wire k,
    output reg  out
);

  parameter OFF = 1'b0, ON = 1'b1;
  reg state, next_state;

  //Determine next state.
  always @(*) begin
    casez ({
      j, k, state
    })
      {2'b1z, OFF} : next_state = ON;
      {2'bz0, ON} : next_state = ON;
      default: next_state = OFF;
    endcase
  end

  //State transition.
  always @(posedge clk, posedge areset) begin
    if (areset) state <= OFF;
    else if (clk) begin
      state <= next_state;
    end
  end

  //Determine output.
  always @(*) begin
    case (state)
      ON: out = 1'b1;
      default: out = 1'b0;
    endcase
  end

endmodule
