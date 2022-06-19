/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire reset,
    input wire [31:0] in,
    output wire [31:0] out
);

  reg [31:0] previous_pin_r = 31'b0;
  reg [31:0] out_r = 31'b0;

  assign out = out_r;

  always @(posedge clk) begin
    if (reset) begin
      out_r = 31'b0;
    end else begin
      out_r <= (previous_pin_r & ~in) | out_r;
    end
    previous_pin_r <= in;
  end

endmodule

