/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module count4 (
    input wire clk,
    input wire enable,
    input wire load,
    input wire [3:0] d,
    output reg [3:0] Q
);

  initial begin
    Q = 4'b0;
  end

  always @(posedge clk) begin
    if (load) begin
      Q <= d;
    end else if (enable) begin
      Q <= Q + 1'b1;
    end
  end

endmodule

