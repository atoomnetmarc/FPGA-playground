/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top (
    input  wire BUT1,
    input  wire BUT2,
    output wire LED1,
    output wire LED2
);

  assign LED1 = ~BUT1;
  assign LED2 = ~BUT2;

endmodule
