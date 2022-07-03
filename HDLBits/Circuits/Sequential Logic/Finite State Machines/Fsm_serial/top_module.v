/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

`define STATE_IDLE 3'b000
`define STATE_START 3'b001
`define STATE_DATA 3'b010
`define STATE_STOP 3'b011
`define STATE_ILLIGAL 3'b111

module top_module (
    input  wire clk,
    input  wire in,
    input  wire reset,
    output reg  done
);

  reg [2:0] state = `STATE_IDLE, next_state = `STATE_IDLE;
  reg [4:0] bits;

  //Determine next state.
  always @(*) begin
    casez ({
      in, state, (bits == 4'd8)
    })
      //Wait for idle state.
      {1'b0, `STATE_IDLE, 1'bz} : next_state = `STATE_IDLE;

      //Idle state found.
      {1'b1, `STATE_IDLE, 1'bz} : next_state = `STATE_START;

      //Wait for start bit.
      {1'b1, `STATE_START, 1'bz} : next_state = `STATE_START;

      //Start bit found.
      {1'b0, `STATE_START, 1'bz} : next_state = `STATE_DATA;

      //Wait for reception of all data bits.
      {1'bz, `STATE_DATA, 1'b0} : next_state = `STATE_DATA;

      //Reception complete but stop bit not found.
      {1'b0, `STATE_DATA, 1'b1} : next_state = `STATE_IDLE;

      //Reception complete.
      {1'b1, `STATE_DATA, 1'b1} : next_state = `STATE_STOP;

      //Start bit found.
      {1'b0, `STATE_STOP, 1'bz} : next_state = `STATE_DATA;

      //Invalid start bit.
      {1'b1, `STATE_STOP, 1'bz} : next_state = `STATE_START;

      //We forgot a state.
      {1'bz, `STATE_ILLIGAL, 1'bz} : next_state = `STATE_ILLIGAL;
      default: next_state = `STATE_ILLIGAL;
    endcase
  end

  //State transition.
  always @(posedge clk) begin
    if (reset)
      state <= `STATE_START;
    else if (clk) begin
      state <= next_state;

      case (state)
        `STATE_START, `STATE_STOP: bits <= 4'd0;
        `STATE_DATA: bits <= (bits < 4'd8) ? bits + 1'b1 : bits;
      endcase
    end
  end

  //Determine output.
  always @(*) begin
    case (state)
      `STATE_STOP: done = 1'b1;
      default: done = 1'b0;
    endcase
  end
endmodule
