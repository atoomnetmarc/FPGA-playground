/*

Copyright 2022 Marc Ketel
SPDX-License-Identifier: Apache-2.0

*/

`default_nettype none

module top_module (
    input wire clk,
    input wire load,
    input wire [511:0] data,
    output reg [511:0] q
);

  integer i;

  always @(posedge clk) begin
    if (load) q <= data;
    else begin
      for (i = 0; i < $bits(q); i = i + 1) begin
        if (i == 0) begin
          case ({
            q[i+1], q[i]
          })
            2'b10:   q[i] <= 1'b0;
            2'b00:   q[i] <= 1'b0;
            default: q[i] <= 1'b1;
          endcase
        end else if (i == $bits(q) - 1) begin
          case ({
            q[i], q[i-1]
          })
            2'b00:   q[i] <= 1'b0;
            default: q[i] <= 1'b1;
          endcase
        end else begin
          case ({
            q[i+1], q[i], q[i-1]
          })
            3'b111:  q[i] <= 1'b0;
            3'b100:  q[i] <= 1'b0;
            3'b000:  q[i] <= 1'b0;
            default: q[i] <= 1'b1;
          endcase
        end
      end
    end
  end

endmodule
