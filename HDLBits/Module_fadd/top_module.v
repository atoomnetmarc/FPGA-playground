/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire [31:0] a,
    input wire [31:0] b,
    output wire [31:0] sum
);

  wire a1c, a2c;
  add16 a1 (
      a[15:0],
      b[15:0],
      1'b0,
      sum[15:0],
      a1c
  );
  add16 a2 (
      a[31:16],
      b[31:16],
      a1c,
      sum[31:16],
      a2c
  );

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
