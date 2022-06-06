/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top (
    input  wire CLK,   //100Mhz clock
    input  wire BUT1,
    input  wire BUT2,
    output wire LED1,
    output wire LED2
);

  reg LED1_r;
  reg LED2_r;

  assign LED1 = LED1_r;
  assign LED2 = LED2_r;

  always @(posedge CLK) begin
    LED1_r <= ~BUT1;
    LED2_r <= ~BUT2;
  end

endmodule
