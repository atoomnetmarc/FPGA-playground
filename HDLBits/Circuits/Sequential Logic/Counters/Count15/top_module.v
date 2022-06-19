/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire       clk,
    input  wire       reset,  // Synchronous active-high reset
    output wire [3:0] q
);

  reg [3:0] counter = 4'b0;

  always @(posedge clk) begin
    if (reset) counter <= 4'b0;
    else counter <= counter + 1'b1;
  end

  assign q = counter;

endmodule
