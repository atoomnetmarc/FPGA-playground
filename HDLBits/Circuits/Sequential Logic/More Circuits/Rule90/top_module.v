/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire load,
    input wire [511:0] data,
    output reg [511:0] q
);

  integer i;

  always @(posedge clk) begin
    if (load) q <= data;
    else begin
      for (i = 0; i < $bits(q); i = i + 1) begin
        if (i == 0) begin
          q[i] <= 1'b0 ^ q[i+1];
        end else if (i == $bits(q) - 1) begin
          q[i] <= q[i-1] ^ 1'b0;
        end else begin
          q[i] <= q[i-1] ^ q[i+1];
        end
      end
    end
  end

endmodule
