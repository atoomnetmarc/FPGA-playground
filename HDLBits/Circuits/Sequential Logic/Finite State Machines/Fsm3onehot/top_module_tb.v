/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  wire [3:0] next_state;
  wire out;

  reg in = 1'd1;
  reg [3:0] state = 2'd00;

  localparam ITERATIONS = 1000;

  always begin
    #5 state = state + 1;
  end

  always begin
    #50 in = 1'b0;
    #50 in = 1'b1;
  end

  top_module uut (
      .in(in),
      .state(state),
      .next_state(next_state),
      .out(out)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
