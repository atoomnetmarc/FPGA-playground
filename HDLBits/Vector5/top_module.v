/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    input wire e,
    output wire [24:0] out
);

  wire [4:0] signals = {a, b, c, d, e};

  assign out[24:20] = ~({5{a}} ^ signals);
  assign out[19:15] = ~({5{b}} ^ signals);
  assign out[14:10] = ~({5{c}} ^ signals);
  assign out[9:5]   = ~({5{d}} ^ signals);
  assign out[4:0]   = ~({5{e}} ^ signals);

endmodule
