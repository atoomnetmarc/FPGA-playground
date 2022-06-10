/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire [3:0] in,
    output wire out_and,
    output wire out_or,
    output wire out_xor
);

  assign out_and = &in;
  assign out_or  = |in;
  assign out_xor = ^in;

endmodule
