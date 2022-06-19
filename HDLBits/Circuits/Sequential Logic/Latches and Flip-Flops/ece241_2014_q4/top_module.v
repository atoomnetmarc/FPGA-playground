/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire x,
    output wire z
);

  wire xor_i, and_i, or_i;
  wire dff1_q, dff2_q, dff3_q;
  wire dff1_qn, dff2_qn, dff3_qn;

  assign xor_i = x ^ dff1_q;
  assign and_i = x & dff2_qn;
  assign or_i  = x | dff3_qn;

  my_dff dff1 (
      clk,
      xor_i,
      dff1_q,
      dff1_qn
  );
  my_dff dff2 (
      clk,
      and_i,
      dff2_q,
      dff2_qn
  );
  my_dff dff3 (
      clk,
      or_i,
      dff3_q,
      dff3_qn
  );

  assign z = ~(dff1_q | dff2_q | dff3_q);


endmodule

module my_dff (
    input  wire clk,
    input  wire d,
    output reg  q,
    output wire qn
);

  initial begin
    q = 0;
  end

  assign qn = ~q;

  always @(posedge clk) begin
    q <= d;
  end

endmodule

