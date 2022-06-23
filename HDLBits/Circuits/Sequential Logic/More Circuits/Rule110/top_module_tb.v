/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();
  reg clk = 1'b1;
  reg load = 1'b0;
  reg [511:0] data = 512'b1;
  wire [511:0] q;

  localparam ITERATIONS = 1024;

  always begin
    #1 clk = clk + 1;
  end

  initial begin
    #2 load = 1'b1;
    #1 load = 1'b0;
  end


  top_module uut (
      .clk(clk),
      .load(load),
      .data(data),
      .q(q)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
