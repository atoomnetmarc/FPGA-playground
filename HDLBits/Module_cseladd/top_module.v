/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire [31:0] a,
    input  wire [31:0] b,
    output wire [31:0] sum
);

  wire carry;
  add16 a1 (
      a[15:0],
      b[15:0],
      1'b0,
      sum[15:0],
      carry
  );

  wire [31:16] sum2a;
  add16 a2a (
      a[31:16],
      b[31:16],
      1'b0,
      sum2a,
  );

  wire [31:16] sum2b;
  add16 a2b (
      a[31:16],
      b[31:16],
      1'b1,
      sum2b,
  );

  assign sum[31:16] = (carry) ? sum2b : sum2a;

endmodule

