/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire reset,
    output wire [3:1] ena,
    output wire [15:0] q
);

  wire [3:0] cQ0, cQ1, cQ2, cQ3;

  assign ena[1] = cQ0 == 9;
  assign ena[2] = ena[1] & cQ1 == 9;
  assign ena[3] = ena[2] & cQ2 == 9;

  assign q = {cQ3, cQ2, cQ1, cQ0};

  bcdcount counter0 (
      clk,
      reset,
      1'b1,
      cQ0
  );
  bcdcount counter1 (
      clk,
      reset,
      ena[1],
      cQ1
  );
  bcdcount counter2 (
      clk,
      reset,
      ena[2],
      cQ2
  );
  bcdcount counter3 (
      clk,
      reset,
      ena[3],
      cQ3
  );

endmodule


module bcdcount (
    input wire clk,
    input wire reset,
    input wire enable,
    output reg [3:0] Q
);

  always @(posedge clk) begin
    if (reset) Q = 0;
    else if (enable)
      if (Q == 4'd9) Q = 0;
      else Q = Q + 1'b1;
  end

endmodule
