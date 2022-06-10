`timescale 1s / 100ms

module top_module_tb ();

  wire out_and;
  wire out_or;
  wire out_xor;

  reg [3:0] stim = 3'd0;

  localparam ITERATIONS = 16;

  always begin
    #1 stim = stim + 1;
  end

  top_module uut (
      .in(stim),
      .out_and(out_and),
      .out_or(out_or),
      .out_xor(out_xor)
  );

  initial begin
    $dumpfile("top_module_tb.vcd");
    $dumpvars(0, top_module_tb);

    #(ITERATIONS) $display("Done simulating.");
    $finish;
  end

endmodule
