/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`timescale 1s / 10ms

module top_module_tb ();
  reg clk = 1'd1;
  reg reset = 1'd0;
  reg [7:0] in = 1'd0;
  wire done;

  localparam ITERATIONS = 1000;

  always begin
    #5 clk = clk + 1;
  end

  always begin
    #10 in = {$random};
    #10 in = {$random};

    #10 in = {$random | 8'h8};
    #10 in = {$random};
    #10 in = {$random};

    #10 in = {$random | 8'h8};
    #10 in = {$random};
    #10 in = {$random};

    #10 in = {$random & ~8'h8};
    #10 in = {$random | 8'h8};
    #10 in = {$random};
    #10 in = {$random};
  end

  initial begin
    #60 reset = 1'b1;
    #10 reset = 1'b0;
  end

  top_module uut (
      .clk(clk),
      .in(in),
      .reset(reset),
      .done(done)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
