/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire areset,
    input wire load,
    input wire ena,
    input wire [3:0] data,
    output reg [3:0] q
);

  always @(posedge clk, posedge areset) begin
    if (areset) q <= 0;
    else if (load) q <= data;
    else if (ena) q = q >> 1;
  end

endmodule
