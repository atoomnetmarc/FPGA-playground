/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire shift_ena,
    input wire count_ena,
    input wire data,
    output wire [3:0] q
);

  reg [3:0] qr = 4'b0;
  assign q = qr;

  always @(posedge clk) begin
    if (shift_ena) begin
      qr <= {qr[2:0], data};
    end

    if (count_ena) begin
      qr <= qr - 1'b1;
    end
  end

endmodule
