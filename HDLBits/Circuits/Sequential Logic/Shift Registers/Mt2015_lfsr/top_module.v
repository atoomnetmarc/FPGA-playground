/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire [2:0] SW,
    input wire [1:0] KEY,
    output wire [2:0] LEDR
);

  reg [2:0] q = 3'b0;
  assign LEDR = q;

  always @(posedge KEY[0]) begin
    if (KEY[1]) q <= SW;
    else begin
      q[2] <= q[2] ^ q[1];
      q[1] <= q[0];
      q[0] <= q[2];
    end
  end

endmodule
