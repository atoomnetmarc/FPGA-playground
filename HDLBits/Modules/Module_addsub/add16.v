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

  assign {cout, sum} = a + b + cin;
endmodule
