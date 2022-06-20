/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module bcdcount (
    input wire clk,
    input wire reset,
    input wire enable,
    output reg [3:0] Q
);

  always @(posedge clk) begin
    if (reset) Q = 0;
    else if (enable)
      if (Q == 4'd9) Q = 0;
      else Q = Q + 1'b1;
  end

endmodule
