/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire [99:0] a,
    input wire [99:0] b,
    input wire cin,
    output wire [99:0] cout,
    output wire [99:0] sum
);


  wire [99:0] carry;

  generate
    genvar i;
    for (i = 0; i < 100; i = i + 1) begin : fooName
      add1 aN (
          a[i],
          b[i],
          (i == 0) ? cin : carry[i-1],
          sum[i],
          carry[i]
      );
    end
  endgenerate

  assign cout = carry;


endmodule

module add1 (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);

  assign {cout, sum} = a + b + cin;
endmodule
