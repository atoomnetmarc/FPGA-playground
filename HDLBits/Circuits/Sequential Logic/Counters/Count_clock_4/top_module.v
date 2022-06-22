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

  reg [3:0] seconds0;
  reg [3:0] seconds1;
  reg [3:0] minutes0;
  reg [3:0] minutes1;
  reg [3:0] hours0;
  reg [3:0] hours1;

  wire increment_seconds1, increment_minutes0, increment_minutes1, increment_hours0, increment_hours1;
  assign increment_seconds1 = seconds0 == 4'd9;
  assign increment_minutes0 = seconds1 == 4'd5 && increment_seconds1;
  assign increment_minutes1 = minutes0 == 4'd9 && increment_minutes0;
  assign increment_hours0   = minutes1 == 4'd5 && increment_minutes1;
  assign increment_hours1   = hours0 == 4'd9 && increment_hours0;

  always @(posedge clk) begin
    if (reset) {hours1, hours0, minutes1, minutes0, seconds1, seconds0} = 24'd0;
    else if (enable) begin
      if ({hours1, hours0, minutes1, minutes0, seconds1, seconds0} == 24'h235959) begin
        {hours1, hours0, minutes1, minutes0, seconds1, seconds0} <= 24'd0;
      end else begin
        if (increment_hours1) begin
          {hours0, minutes1, minutes0, seconds1, seconds0} <= 1'd0;
          hours1 <= hours1 + 1'd1;
        end else if (increment_hours0) begin
          {minutes1, minutes0, seconds1, seconds0} <= 1'd0;
          hours0 <= hours0 + 1'd1;
        end else if (increment_minutes1) begin
          {minutes0, seconds1, seconds0} <= 1'd0;
          minutes1 <= minutes1 + 1'd1;
        end else if (increment_minutes0) begin
          {seconds1, seconds0} <= 1'd0;
          minutes0 <= minutes0 + 1'd1;
        end else if (increment_seconds1) begin
          {seconds0} <= 1'd0;
          seconds1   <= seconds1 + 1'd1;
        end else begin
          seconds0 = seconds0 + 1'd1;
        end
      end

    end
  end

  assign Q = {hours1, hours0, minutes1, minutes0, seconds1, seconds0};

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
