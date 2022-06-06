`timescale 1ns / 10ps

module top_tb ();

  wire LED1;
  wire LED2;

  reg  BUT1 = 0;
  reg  BUT2 = 0;

  localparam ITERATIONS = 10000;

  always begin
    #314 BUT2 = ~BUT2;
  end

  top uut (
      .BUT1(BUT1),
      .BUT2(BUT2),
      .LED1(LED1),
      .LED2(LED2)
  );

  initial begin
    #1000 BUT1 = 1'b1;
    #2000 BUT1 = 1'b0;
  end

  initial begin
    $dumpfile("top_tb.vcd");
    $dumpvars(0, top_tb);

    #(ITERATIONS)
    $display("Done simulating.");
    $finish;
  end

endmodule
