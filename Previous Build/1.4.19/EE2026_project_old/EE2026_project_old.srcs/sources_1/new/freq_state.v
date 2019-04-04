`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2019 11:40:56
// Design Name: 
// Module Name: freq_state
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


module freq_state(input clk_wire, wave_sample_raw, output freq_state);
    reg state = 0;

    always @ (posedge clk_wire) begin
        state <= (wave_sample_raw == 2048 ? ~state : state);
    
    end

    assign freq_state = state;

endmodule
