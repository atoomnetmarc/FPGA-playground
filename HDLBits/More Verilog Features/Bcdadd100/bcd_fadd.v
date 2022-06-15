/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module bcd_fadd (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       cin,
    output wire       cout,
    output wire [3:0] sum
);

  reg [4:0] large_sum;
  assign {cout, sum} = large_sum;

  always @(*) begin
    large_sum = cin + a + b;
    if (large_sum > 9) large_sum = large_sum + 6;
  end

endmodule
