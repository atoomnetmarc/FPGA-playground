/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire j,
    input  wire k,
    output wire Q
);

  wire dff_d, dff_q, dff_qn;

  my_dff dff1 (
      .clk(clk),
      .d  (dff_d),
      .q  (dff_q),
      .qn (dff_qn)
  );

  assign Q = dff_q;
  assign dff_d = (dff_qn & j) | (~k & dff_q);

endmodule

module my_dff (
    input  wire clk,
    input  wire d,
    output reg  q,
    output wire qn
);

  assign qn = ~q;

  always @(posedge clk) begin
    q <= d;
  end

endmodule

