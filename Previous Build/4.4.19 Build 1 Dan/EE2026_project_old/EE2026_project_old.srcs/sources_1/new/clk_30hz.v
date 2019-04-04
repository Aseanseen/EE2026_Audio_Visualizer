`timescale 1ns / 1ps
/**
 * 30 Hz Clock for color selector
 */

module clk_30hz(
    input clk,
    output reg clk_new
    );
    
    reg [17:0] count = 0;
    
    always @(posedge clk) begin
        clk_new <= (count >= 166666) ? ~clk_new : clk_new;
        count <= (count >= 166666) ? 0 : (count + 1);
    end
endmodule