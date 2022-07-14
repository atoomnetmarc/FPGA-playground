/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire aresetn,
    input  wire x,
    output reg  z
);

  parameter STATE_S0 = 2'b00;
  parameter STATE_S1 = 2'b01;
  parameter STATE_S2 = 2'b10;
  parameter STATE_ILLEGAL = 2'b11;

  reg [1:0] state, next_state = STATE_S0;

  //Determine next state.
  always @(*) begin
    casez ({
      x, state
    })
      {1'b0, STATE_S0} : next_state = STATE_S0;
      {1'b1, STATE_S0} : next_state = STATE_S1;

      {1'b0, STATE_S1} : next_state = STATE_S2;
      {1'b1, STATE_S1} : next_state = STATE_S1;

      {1'b0, STATE_S2} : next_state = STATE_S0;
      {1'b1, STATE_S2} : next_state = STATE_S1;

      default: next_state = STATE_ILLEGAL;
    endcase
  end

  //State transition.
  always @(posedge clk, negedge aresetn) begin
    if (~aresetn) state <= STATE_S0;
    else if (clk) state <= next_state;
  end

  //Determine output.
  always @(*) begin
    case ({
      state, x
    })
      {STATE_S0, 1'b0} : z = 1'b0;
      {STATE_S0, 1'b1} : z = 1'b0;
      {STATE_S1, 1'b0} : z = 1'b0;
      {STATE_S1, 1'b1} : z = 1'b0;
      {STATE_S2, 1'b0} : z = 1'b0;
      {STATE_S2, 1'b1} : z = 1'b1;
      default: z = 1'bx;
    endcase
  end

endmodule
