`timescale 1s / 100ms

module top_module_tb ();

  wire [24:0] out;

  reg  [ 4:0] stim = 5'd0;

  localparam ITERATIONS = 32;

  always begin
    #1 stim = stim + 1;
  end

  top_module uut (
      stim[0],
      stim[1],
      stim[2],
      stim[3],
      stim[4],
      out
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
