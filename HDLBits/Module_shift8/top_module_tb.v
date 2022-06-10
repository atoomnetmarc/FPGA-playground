/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 100ms

module top_module_tb ();

  reg clk = 0;

  reg [7:0] d = 8'd0;
  reg [1:0] sel = 2'd0;
  wire [7:0] q;

  reg [2:0] stim_a = 2'd0;
  reg [2:0] stim_b = 2'd0;

  localparam ITERATIONS = 10240;

  always begin
    clk = clk + 1;
    #10;
  end

  always begin
    #5 d = d + 1;
    #15;
  end

  always begin
    #2560 sel = sel + 1;
  end

  top_module uut (
      .clk(clk),
      .d  (d),
      .sel(sel),
      .q  (q)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
