/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input [3:0] in,
    output reg [1:0] pos
);

  integer i;
  reg bitfound;
  always @(*) begin
    pos = 0;
    bitfound = 0;
    for (i = 0; i < 4; i = i + 1) begin
      if (in[i] && !bitfound) begin
        bitfound = 1'b1;
        pos = i;
      end
    end
  end

endmodule

