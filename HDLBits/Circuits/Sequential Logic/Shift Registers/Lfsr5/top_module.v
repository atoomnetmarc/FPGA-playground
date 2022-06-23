/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire reset,
    output wire [4:0] q
);

  reg [4:0] q_i;
  assign q = q_i;

  always @(posedge clk) begin
    if (reset) q_i <= {5{1'b1}};
    else begin
      q_i[0] <= q_i[1];
      q_i[1] <= q_i[2];
      q_i[2] <= q_i[3] ^ q_i[0];
      q_i[3] <= q_i[4];
      q_i[4] <= q_i[0] ^ 1'b0;
    end
  end

endmodule
