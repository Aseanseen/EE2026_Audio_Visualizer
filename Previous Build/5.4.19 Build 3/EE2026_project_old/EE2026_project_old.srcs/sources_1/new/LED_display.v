`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2019 09:22:02
// Design Name: 
// Module Name: LED_display
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


module LED_display(input CLK, [11:0] wave_sample_raw, output [11:0] LED);
    reg [11:0] led;
    reg [11:0] maxVol;
    reg [3:0] maxLedNum;
    reg [3:0] curLedNum;
    reg [24:0] COUNTER;
    
    always @ (posedge CLK) begin
        COUNTER <= (COUNTER >= 33333333 ? 0 : COUNTER + 3);
        maxVol <= (wave_sample_raw > maxVol ? wave_sample_raw : maxVol);
        if (COUNTER == 0) begin
            //maxLedNum <= ((maxVol >> 6) << 6) / 300;
            maxLedNum <= (maxVol - 2047) / 165;
            //maxLedNum <= (maxVol - 2047) / 170;
            curLedNum <= (maxLedNum >= curLedNum ? maxLedNum : (curLedNum - 1));
            case (curLedNum)
                0: begin led = 0; end
                1: begin led = 12'b000000000001; end
                2: begin led = 12'b000000000011; end
                3: begin led = 12'b000000000111; end
                4: begin led = 12'b000000001111; end
                5: begin led = 12'b000000011111; end
                6: begin led = 12'b000000111111; end
                7: begin led = 12'b000001111111; end
                8: begin led = 12'b000011111111; end
                9: begin led = 12'b000111111111; end
                10:begin led = 12'b001111111111; end
                11:begin led = 12'b011111111111; end
                12:begin led = 12'b111111111111; end
                13:begin led = 12'b111111111111; end
                14:begin led = 12'b111111111111; end
                
           endcase
           maxVol <= 0;
        end
        
    end
    assign LED = led;
    
    
endmodule
