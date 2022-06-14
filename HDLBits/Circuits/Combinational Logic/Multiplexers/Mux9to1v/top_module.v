/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire [15:0] a,
    input  wire [15:0] b,
    input  wire [15:0] c,
    input  wire [15:0] d,
    input  wire [15:0] e,
    input  wire [15:0] f,
    input  wire [15:0] g,
    input  wire [15:0] h,
    input  wire [15:0] i,
    input  wire [ 3:0] sel,
    output wire [15:0] out
);

  reg [15:0] out_i;
  always @(*) begin
    case (sel)
      4'd0: out_i = a;
      4'd1: out_i = b;
      4'd2: out_i = c;
      4'd3: out_i = d;
      4'd4: out_i = e;
      4'd5: out_i = f;
      4'd6: out_i = g;
      4'd7: out_i = h;
      4'd8: out_i = i;
      default: out_i = {16{1'b1}};
    endcase
  end

  assign out = out_i;

endmodule
