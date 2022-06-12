/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top (
    input  wire CLK,   //100Mhz clock
    input  wire BUT1,
    output wire LED1,
    output wire LED2
);

  blocking blk1 (
      CLK,
      BUT1,
      LED1
  );
  nonblocking nblk1 (
      CLK,
      BUT1,
      LED2
  );

endmodule

module blocking (
    input  wire CLK,
    input  wire BUT,
    output wire LED
);

  reg b1, b2, b3;

  /*
  Blocking assignments will have the effect that it will execute after each other. In this example that means that b3 has the same value as BUT after 1 clock cyle. It creates combinatory logic.
  */
  always @(posedge CLK) begin
    b1 = BUT;
    b2 = b1;
    b3 = b2;
  end

  assign LED = ~b3;


endmodule


module nonblocking (
    input  wire CLK,
    input  wire BUT,
    output wire LED
);

  reg nb1, nb2, nb3;

  /*
  Non blocking assignment will have the effect that all is executed at the same time. In this example nb1 will get assigned the value of BUT and nb2 will get assigned the value that nb1 had the previous clockcycle. It creates sequential logic.
  */
  always @(posedge CLK) begin
    nb1 <= BUT;
    nb2 <= nb1;
    nb3 <= nb2;
  end

  assign LED = ~nb3;

endmodule
