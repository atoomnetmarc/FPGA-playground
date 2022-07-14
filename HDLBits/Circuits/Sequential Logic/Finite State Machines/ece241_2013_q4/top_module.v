/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire reset,
    input wire [3:1] s,  //Water level
    output reg fr3,
    output reg fr2,
    output reg fr1,
    output reg dfr
);

  parameter FLOW_L0 = 2'h0;
  parameter FLOW_L1 = 2'h1;
  parameter FLOW_L2 = 2'h2;
  parameter FLOW_L3 = 2'h3;
  parameter FLOW_SUPPLEMENTAL_OFF = 1'b0;
  parameter FLOW_SUPPLEMENTAL_ON = 1'b1;

  parameter WATER_LEVEL_NO = 3'b000;
  parameter WATER_LEVEL_LOW = 3'b001;
  parameter WATER_LEVEL_MEDIUM = 3'b011;
  parameter WATER_LEVEL_HIGH = 3'b111;

  reg [1:0] state_flowrate, next_state_flowrate;
  reg state_flowrate_supplemental, next_state_flowrate_supplemental;

  //Determine next state.
  always @(*) begin
    case (s)
      WATER_LEVEL_HIGH : next_state_flowrate = FLOW_L0;
      WATER_LEVEL_MEDIUM : next_state_flowrate = FLOW_L1;
      WATER_LEVEL_LOW : next_state_flowrate = FLOW_L2;
      WATER_LEVEL_NO : next_state_flowrate = FLOW_L3;
      default: next_state_flowrate = FLOW_L0;
    endcase

    case({state_flowrate, next_state_flowrate})
      {FLOW_L0, FLOW_L1}: next_state_flowrate_supplemental = FLOW_SUPPLEMENTAL_ON;
      {FLOW_L1, FLOW_L2}: next_state_flowrate_supplemental = FLOW_SUPPLEMENTAL_ON;
      {FLOW_L2, FLOW_L3}: next_state_flowrate_supplemental = FLOW_SUPPLEMENTAL_ON;

      {FLOW_L3, FLOW_L2}: next_state_flowrate_supplemental = FLOW_SUPPLEMENTAL_OFF;
      {FLOW_L2, FLOW_L1}: next_state_flowrate_supplemental = FLOW_SUPPLEMENTAL_OFF;
      {FLOW_L1, FLOW_L0}: next_state_flowrate_supplemental = FLOW_SUPPLEMENTAL_OFF;
      default: next_state_flowrate_supplemental = state_flowrate_supplemental;
    endcase
  end

  //State transition.
  always @(posedge clk) begin
    if (reset) begin
      state_flowrate <= FLOW_L3;
      state_flowrate_supplemental <= FLOW_SUPPLEMENTAL_ON;
    end else if (clk) begin
      state_flowrate <= next_state_flowrate;
      state_flowrate_supplemental <= next_state_flowrate_supplemental;
    end
  end

  //Determine output.
  always @(*) begin
    case (state_flowrate)
      FLOW_L1: {fr3, fr2, fr1} = 3'b001;
      FLOW_L2: {fr3, fr2, fr1} = 3'b011;
      FLOW_L3: {fr3, fr2, fr1} = 3'b111;
      default:  {fr3, fr2, fr1} = 3'b000;
    endcase

    case (state_flowrate_supplemental)
      FLOW_SUPPLEMENTAL_ON: dfr = 1'b1;
      default: dfr = 1'b0;
    endcase
  end
endmodule
