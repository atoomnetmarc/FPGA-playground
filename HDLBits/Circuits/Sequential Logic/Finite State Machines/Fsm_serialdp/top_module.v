/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire in,
    input wire reset,
    output wire [7:0] out_byte,
    output wire done
);

  wire [2:0] state, next_state;
  wire [4:0] bits;
  wire [9:0] data;

  //Determine next state.
  fsm_next_state ns (
      .in(in),
      .state(state),
      .bits(bits),
      .next_state(next_state)
  );

  //State transition.
  fsm_state_transition st (
      .clk(clk),
      .in(in),
      .reset(reset),
      .next_state(next_state),
      .bits(bits),
      .state(state),
      .data(data)
  );

  //Determine output.
  fsm_output o (
      .state(state),
      .data(data),
      .out_byte(out_byte),
      .done(done)
  );
endmodule


module fsm_next_state (
    input wire in,
    input wire [2:0] state,
    input wire [4:0] bits,
    output reg [2:0] next_state
);

  parameter STATE_IDLE = 3'b000;
  parameter STATE_START = 3'b001;
  parameter STATE_DATA = 3'b010;
  parameter STATE_STOP = 3'b011;
  parameter STATE_ILLIGAL = 3'b111;

  always @(*) begin
    casez ({
      in, state, (bits == 4'd9)
    })
      //Wait for idle state.
      {1'b0, STATE_IDLE, 1'bz} : next_state = STATE_IDLE;

      //Idle state found.
      {1'b1, STATE_IDLE, 1'bz} : next_state = STATE_START;

      //Wait for start bit.
      {1'b1, STATE_START, 1'bz} : next_state = STATE_START;

      //Start bit found.
      {1'b0, STATE_START, 1'bz} : next_state = STATE_DATA;

      //Wait for reception of all data bits and parity bit.
      {1'bz, STATE_DATA, 1'b0} : next_state = STATE_DATA;

      //Reception complete but stop bit not found.
      {1'b0, STATE_DATA, 1'b1} : next_state = STATE_IDLE;

      //Reception complete.
      {1'b1, STATE_DATA, 1'b1} : next_state = STATE_STOP;

      //Start bit found.
      {1'b0, STATE_STOP, 1'bz} : next_state = STATE_DATA;

      //Invalid start bit.
      {1'b1, STATE_STOP, 1'bz} : next_state = STATE_START;

      //We forgot a state.
      {1'bz, STATE_ILLIGAL, 1'bz} : next_state = STATE_ILLIGAL;
      default: next_state = STATE_ILLIGAL;
    endcase
  end

endmodule

module fsm_state_transition (
    input wire clk,
    input wire in,
    input wire reset,
    input wire [2:0] next_state,
    output reg [4:0] bits,
    output reg [2:0] state,
    output reg [9:0] data
);

  parameter STATE_START = 3'b001;
  parameter STATE_DATA = 3'b010;
  parameter STATE_STOP = 3'b011;

  always @(posedge clk) begin
    if (reset) state <= STATE_START;
    else if (clk) begin
      state <= next_state;

      case (state)
        STATE_START, STATE_STOP: bits <= 4'd0;
        STATE_DATA: bits <= (bits < 4'd9) ? bits + 1'b1 : bits;
      endcase

      data <= data >> 1;
      data[9] <= in;
    end
  end
endmodule

module fsm_output (
    input wire [2:0] state,
    input wire [9:0] data,
    output reg [7:0] out_byte,
    output reg done
);

  parameter STATE_STOP = 3'b011;

  always @(*) begin
    case (state)
      STATE_STOP: done = ^data[8:0] == data[9];  //Check odd parity
      default: done = 1'b0;
    endcase

    out_byte = data[7:0];
  end
endmodule
