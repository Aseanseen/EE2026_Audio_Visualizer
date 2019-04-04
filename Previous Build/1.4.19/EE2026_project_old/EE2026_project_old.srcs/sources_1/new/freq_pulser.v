`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2019 19:54:37
// Design Name: 
// Module Name: freq_pulser
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


module freq_pulser(input clk_wire, wave_sample_raw, output [11:0] COUNTER);
    wire freqState = 0;
    reg [11:0] counter = 0;
    
    freq_state fs(clk_wire, wave_sample_raw, freqState);

    always @ (posedge freqState) begin
        counter <= (counter > 10000 ? 0 : counter + 1);
    end
    
    assign COUNTER = counter;
    
endmodule
