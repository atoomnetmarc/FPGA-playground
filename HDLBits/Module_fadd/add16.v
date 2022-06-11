/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module add16 (
    input wire [15:0] a,
    input wire [15:0] b,
    input wire cin,
    output wire [15:0] sum,
    output wire cout
);

  wire carry[15:0];

  generate
    genvar i;
    for (i = 0; i < 16; i = i + 1) begin
      add1 aN (
          a[i],
          b[i],
          (i == 0) ? cin : carry[i-1],
          sum[i],
          carry[i]
      );
    end
  endgenerate

  assign cout = carry[$bits(sum)-1];
endmodule
