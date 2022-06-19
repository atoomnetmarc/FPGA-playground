/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire reset,
    input wire enable,
    output wire [3:0] Q,
    output wire c_enable,
    output wire c_load,
    output wire [3:0] c_d
);

  wire counter_load;
  wire counter_enable;
  reg [3:0] counter_d = 4'd1;

  count4 the_counter (
      .clk(clk),
      .enable(counter_enable),
      .load(counter_load),
      .d(counter_d),
      .Q(Q)
  );

  assign counter_enable = enable;
  assign counter_load = (Q == 4'd12 & counter_enable) | reset;

  assign c_enable = counter_enable;
  assign c_load = counter_load;
  assign c_d = counter_d;

endmodule

