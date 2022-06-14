/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [7:0] c,
    input  wire [7:0] d,
    output wire [7:0] min
);

  //This oneliner costs 119 ice40 logic cells.
  /*
  assign min = (a < b && a < c && a < d) ? a :
               (b < c && b < d) ? b :
               (c < d) ? c :
               d;
  */

  //This is not the point of the exercise, but it is much clearer and as a bonus only consumes 75 ice40 logic cells.
  reg [7:0] min_i;
  always @(*) begin
    min_i = a;
    if (b < min_i) min_i = b;
    if (c < min_i) min_i = c;
    if (d < min_i) min_i = d;
  end

  assign min = min_i;

endmodule

