/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire [3:0] SW,
    input  wire [3:0] KEY,
    output wire [3:0] LEDR
);

  wire clk, E, L, w;
  assign clk = KEY[0];
  assign E   = KEY[1];
  assign L   = KEY[2];
  assign w   = KEY[3];

  MUXDFF md3 (
      clk,
      w,
      SW[3],
      E,
      L,
      LEDR[3]
  );
  MUXDFF md2 (
      clk,
      LEDR[3],
      SW[2],
      E,
      L,
      LEDR[2]
  );
  MUXDFF md1 (
      clk,
      LEDR[2],
      SW[1],
      E,
      L,
      LEDR[1]
  );
  MUXDFF md0 (
      clk,
      LEDR[1],
      SW[0],
      E,
      L,
      LEDR[0]
  );

endmodule

module MUXDFF (
    input  wire clk,
    input  wire w,
    input  wire R,
    input  wire E,
    input  wire L,
    output reg  Q
);
  wire Eo;
  assign Eo = E ? w : Q;

  always @(posedge clk) begin
    Q <= L ? R : Eo;
  end

endmodule
