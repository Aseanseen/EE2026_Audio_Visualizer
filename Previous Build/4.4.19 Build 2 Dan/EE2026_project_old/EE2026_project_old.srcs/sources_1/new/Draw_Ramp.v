`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2019 11:42:49
// Design Name: 
// Module Name: Draw_Ramp
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


module Draw_Ramp(
    input clk_wire,
    output reg [9:0] ramp_data
    );
    
    reg [9:0] Sample_Memory[1279:0];
    reg [10:0] i = 0;
    
    always @ (posedge clk_wire) begin
        i = (i==1279) ? 0 : i + 1;
        ramp_data <= (ramp_data >= 511) ? 0 : ramp_data + 1;
    end
    
endmodule
