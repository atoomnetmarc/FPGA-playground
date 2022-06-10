/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module my_dff8 (
    input wire clk,
    input wire [7:0] d,
    output reg [7:0] q
);

  always @(posedge clk) begin
    q <= d;
  end

endmodule
