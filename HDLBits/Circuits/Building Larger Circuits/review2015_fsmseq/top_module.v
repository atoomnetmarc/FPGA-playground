/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input  wire clk,
    input  wire reset,
    input  wire data,
    output reg  start_shifting
);

  reg [3:0] bitstream;

  always @(posedge clk) begin
    if (reset) begin
      start_shifting <= 1'b0;
      bitstream <= 3'b0;
    end else begin
      bitstream <= {bitstream[2:0], data};

      if ({bitstream[2:0], data} == 4'b1101) start_shifting <= 1'b1;
    end
  end

endmodule
