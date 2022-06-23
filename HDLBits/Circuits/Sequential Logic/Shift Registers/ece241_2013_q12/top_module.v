/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire enable,
    input  wire S,
    input  wire A,
    input  wire B,
    input  wire C,
    output wire Z
);

  reg [7:0] Q = 8'h0;
  assign Z = Q[{A, B, C}];

  always @(posedge clk) begin
    if (enable) begin
      Q <= Q << 1'h1;
      Q[0] <= S;
    end
  end

endmodule
