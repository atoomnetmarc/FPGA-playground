/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire reset,
    output wire OneHertz,
    output wire [2:0] c_enable
);

  wire [3:0] cQ0, cQ1, cQ2;

  assign c_enable[0] = 1;
  assign c_enable[1] = cQ0 == 9;
  assign c_enable[2] = cQ0 == 9 & cQ1 == 9;

  assign OneHertz = cQ0 == 9 & cQ1 == 9 & cQ2 == 9;

  bcdcount counter0 (
      clk,
      reset,
      c_enable[0],
      cQ0
  );
  bcdcount counter1 (
      clk,
      reset,
      c_enable[1],
      cQ1
  );
  bcdcount counter2 (
      clk,
      reset,
      c_enable[2],
      cQ2
  );

endmodule

