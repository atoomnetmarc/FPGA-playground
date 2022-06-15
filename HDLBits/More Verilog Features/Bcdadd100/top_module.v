/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire [399:0] a,
    input wire [399:0] b,
    input wire cin,
    output wire cout,
    output wire [399:0] sum
);

  wire [99:0] carry;

  generate
    genvar i;
    for (i = 0; i < 100; i = i + 1) begin : fooName
      bcd_fadd bcd_add_N (
          a[4*i+:4],
          b[4*i+:4],
          (i == 0) ? cin : carry[i-1],
          carry[i],
          sum[4*i+:4]
      );
    end
  endgenerate

  assign cout = carry[99];


endmodule
