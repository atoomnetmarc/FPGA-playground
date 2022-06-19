/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire d,
    output wire q
);

  reg qp = 1'b0;
  reg qn = 1'b0;

  always @(posedge clk) begin
    qp <= d ^ qn;
  end

  always @(negedge clk) begin
    qn <= d ^ qp;
  end

  assign q = qp ^ qn;

endmodule

