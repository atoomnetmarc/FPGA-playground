/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire [31:0] a,
    input wire [31:0] b,
    input wire sub,
    output wire [31:0] sum
);

  wire [31:0] bsub;

  assign bsub = sub ? ~b : b;

  wire carry;
  add16 a1 (
      .a(a[15:0]),
      .b(bsub[15:0]),
      .cin(sub),
      .sum(sum[15:0]),
      .cout(carry)
  );

  add16 a2 (
      .a(a[31:16]),
      .b(bsub[31:16]),
      .cin(carry),
      .sum(sum[31:16]),
      .cout()
  );

endmodule

