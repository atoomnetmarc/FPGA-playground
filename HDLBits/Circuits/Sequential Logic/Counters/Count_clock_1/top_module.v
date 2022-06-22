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
    output reg [23:0] Q
);

  always @(posedge clk) begin
    if (reset) Q = 24'h0;
    else if (enable) begin
      //dig 4+5, 0-23
      if (Q[23:0] == 24'h235959) Q <= 24'h0;
      else if (Q[19:0] == 20'h95959) Q <= Q + 20'h6A6A7;

      //digit 2+3, 0-59
      else if (Q[15:0] == 16'h5959) Q <= Q + 16'hA6A7;
      else if (Q[11:0] == 12'h959) Q <= Q + 12'h6A7;

      //digit 0+1, 0-59
      else if (Q[7:0] == 8'h59) Q <= Q + 8'hA7;
      else if (Q[3:0] == 4'h9) Q <= Q + 4'h7;

      else Q <= Q + 1'h1;
    end
  end

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
