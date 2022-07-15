/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module(
	input wire clk,
	input wire load,
	input wire [9:0] data,
	output wire tc
);
  reg [9:0] q = 1'b0;

  assign tc = (q == 1'b0);

  always @(posedge clk) begin
    if (load) begin
      q <= data;
    end

    if (~load & ~tc) begin
      q <= q - 1'b1;
    end
  end
endmodule
