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

  wire [24:0] signals_a = {{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}};
  wire [24:0] signals_b = {5{a, b, c, d, e}};
  assign out = signals_a ~^ signals_b;

endmodule
