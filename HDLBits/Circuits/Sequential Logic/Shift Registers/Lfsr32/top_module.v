/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire reset,
    output wire [31:0] q
);

  reg [32:1] q_i;
  assign q = q_i;

  always @(posedge clk) begin
    if (reset) q_i <= 32'd1;
    else begin
      q_i[1] <= q_i[2] ^ q_i[1];
      q_i[2] <= q_i[3] ^ q_i[1];
      q_i[21:3] <= q_i[22:4];
      q_i[22] <= q_i[23] ^ q_i[1];
      q_i[31:23] <= q_i[32:24];
      q_i[32] <= q_i[1] ^ 1'b0;
    end
  end

endmodule
