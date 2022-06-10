/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire [7:0] d,
    input wire [1:0] sel,
    output wire [7:0] q
);

  reg  [7:0] q_i;

  wire [7:0] q1;
  wire [7:0] q2;
  wire [7:0] q3;

  my_dff8 m1 (
      clk,
      d,
      q1
  );
  my_dff8 m2 (
      clk,
      q1,
      q2
  );
  my_dff8 m3 (
      clk,
      q2,
      q3
  );

  assign q = q_i;

  always @(*) begin
    case (sel)
      2'd1: q_i = q1;
      2'd2: q_i = q2;
      2'd3: q_i = q3;
      default: q_i = d;
    endcase
  end

endmodule
