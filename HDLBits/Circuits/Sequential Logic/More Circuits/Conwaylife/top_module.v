/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire load,
    input wire [(SIZE_X*SIZE_Y)-1:0] data,
    output reg [(SIZE_X*SIZE_Y)-1:0] q
);

  //Fixed width 16x16, do not change without manually changing the matrix view below.
  parameter SIZE_X = 16;
  parameter SIZE_Y = 16;

  //gtkwave debug matrix view of array.
  wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15;
  assign r0  = q[0+:SIZE_X];
  assign r1  = q[16+:SIZE_X];
  assign r2  = q[32+:SIZE_X];
  assign r3  = q[48+:SIZE_X];
  assign r4  = q[64+:SIZE_X];
  assign r5  = q[80+:SIZE_X];
  assign r6  = q[96+:SIZE_X];
  assign r7  = q[112+:SIZE_X];
  assign r8  = q[128+:SIZE_X];
  assign r9  = q[144+:SIZE_X];
  assign r10 = q[160+:SIZE_X];
  assign r11 = q[176+:SIZE_X];
  assign r12 = q[192+:SIZE_X];
  assign r13 = q[208+:SIZE_X];
  assign r14 = q[224+:SIZE_X];
  assign r15 = q[240+:SIZE_X];

  integer x, y;

  //Defines for easy use of wrapping coordinates.
  `define LEFT_X ((x==0)?SIZE_Y-1 : x-1)
  `define RIGHT_X ((x==SIZE_Y-1)?0 : x+1)
  `define ABOVE_Y ((y==0)?SIZE_X-1 : y-1)
  `define BELOW_Y ((y==SIZE_X-1)?0 : y+1)

  always @(posedge clk) begin
    if (load) q <= data;
    else begin
      for (y = 0; y < SIZE_Y; y = y + 1) begin
        for (x = 0; x < SIZE_X; x = x + 1) begin
          //Count neighbors.
          case (q[`LEFT_X+`ABOVE_Y*SIZE_X]
          + q[x+`ABOVE_Y*SIZE_X]
          + q[`RIGHT_X+`ABOVE_Y*SIZE_X]
          + q[`LEFT_X+y*SIZE_X]
          + q[`RIGHT_X+y*SIZE_X]
          + q[`LEFT_X+`BELOW_Y*SIZE_X]
          + q[x+`BELOW_Y*SIZE_X]
          + q[`RIGHT_X+`BELOW_Y*SIZE_X]
          )
          //Determine life/death of cell.
            4'd2: q[x+y*SIZE_X] <= q[x+y*SIZE_X];
            4'd3: q[x+y*SIZE_X] <= 1'b1;
            default: q[x+y*SIZE_X] <= 1'b0;
          endcase
        end
      end
    end
  end

endmodule
