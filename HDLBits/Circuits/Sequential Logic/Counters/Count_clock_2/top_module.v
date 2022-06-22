/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire reset,
    input wire ena,
    output wire pm,
    output wire [7:0] hh,
    output wire [7:0] mm,
    output wire [7:0] ss
);

  wire [23:0] bcd24h;

  bcdcount24h standard_time_format (
      .clk(clk),
      .reset(reset),
      .enable(ena),
      .Q(bcd24h)
  );

  bcd24h2complex12h really_complex_time_format (
      .bcd24h(bcd24h),
      .pm(pm),
      .bcd12h({hh, mm, ss})
  );

endmodule

module bcdcount24h (
    input wire clk,
    input wire reset,
    input wire enable,
    output wire [23:0] Q
);

  reg [16:0] secondcounter;
  wire [5:0] seconds;
  wire [5:0] minutes;
  wire [4:0] hours;

  always @(posedge clk) begin
    if (reset) secondcounter = 1'd0;
    else if (enable) begin
      if (secondcounter == 17'd86399)
        secondcounter <= 1'd0;
      else
        secondcounter = secondcounter + 1'd1;
    end
  end

  assign seconds = secondcounter % 60;
  assign minutes = secondcounter / 60 % 60;
  assign hours = secondcounter / 60 / 60 % 60;

  assign Q[3:0] = seconds % 10;
  assign Q[7:4] = seconds / 10;
  assign Q[11:8] = minutes % 10;
  assign Q[15:12] = minutes / 10;
  assign Q[19:16] = hours % 10;
  assign Q[23:20] = hours / 10;

endmodule

module bcd24h2complex12h (
    input wire [23:0] bcd24h,
    output reg pm,
    output reg [23:0] bcd12h
);

  always @(*) begin
    if (bcd24h >= 24'h000000 & bcd24h < 24'h010000) begin
      bcd12h = bcd24h + 24'h120000;
    end else if (bcd24h >= 24'h130000 & bcd24h < 24'h200000) begin
      bcd12h = bcd24h - 24'h120000;
    end else if (bcd24h >= 24'h200000 & bcd24h < 24'h220000) begin
      bcd12h = bcd24h - 24'h180000;
    end else if (bcd24h >= 24'h220000) begin
      bcd12h = bcd24h - 24'h120000;
    end else begin
      bcd12h = bcd24h;
    end

    if (bcd24h < 24'h120000) pm = 0;
    else pm = 1;
  end
endmodule
