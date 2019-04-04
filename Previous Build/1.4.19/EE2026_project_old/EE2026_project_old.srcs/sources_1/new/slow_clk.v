`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2019 20:12:38
// Design Name: 
// Module Name: slow_clk
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module slow_clk(input CLOCK, output CLOCKSTATE);
    reg clockstate = 0;
    reg [28:0] COUNTER = 1;
    
    always @ (posedge CLOCK) begin
        COUNTER <= (COUNTER > 29'b11111110010100000010101011000 ? 0 : COUNTER + 1);
        clockstate <= (COUNTER == 0 ? ~clockstate : clockstate);
    end
    
    assign CLOCKSTATE = clockstate;

endmodule
