/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire [7:0] in,
    output wire [7:0] pedge
);

  reg [7:0] previous_pin_r = 8'b0;
  reg [7:0] pedge_r = 8'b0;

  assign pedge = pedge_r;

  always @(posedge clk) begin
    pedge_r <= ~previous_pin_r & in;
    previous_pin_r <= in;
  end

endmodule


