`timescale 1ns / 1ps

/**
 * Converts input wave_sample_raw into output for LED and 7SEG display
 * LED output is a 12bit bus (mapped to each LED), is assigned here for simplicity
 * 7SEG output is 2x 3bit bus (corresponding to number to print)
 */

module Sound_Lvl_Converter(input CLK, [11:0] wave_sample_raw, output [11:0] LED, [5:0] SOUND0, [5:0] SOUND1);
    reg [11:0] led;
    reg [11:0] maxVol;
    reg [3:0] maxLedNum;
    reg [3:0] curLedNum;
    reg [24:0] COUNTER;
    reg [5:0] sound0;
    reg [5:0] sound1;
    
    always @ (posedge CLK) begin
        COUNTER <= (COUNTER >= 33333333 ? 0 : COUNTER + 3);
        maxVol <= (wave_sample_raw > maxVol ? wave_sample_raw : maxVol);
        if (COUNTER == 0) begin
            //maxLedNum <= ((maxVol >> 6) << 6) / 300;
            maxLedNum <= (maxVol - 2047) / 165;
            //maxLedNum <= (maxVol - 2047) / 170;
            curLedNum <= (maxLedNum >= curLedNum ? maxLedNum : (curLedNum - 1));
            case (curLedNum)
                0: begin led = 0; sound0 = 0; sound1 = 0; end
                1: begin led = 12'b000000000001; sound0 = 0; sound1 = 1; end
                2: begin led = 12'b000000000011; sound0 = 0; sound1 = 2; end
                3: begin led = 12'b000000000111; sound0 = 0; sound1 = 3; end
                4: begin led = 12'b000000001111; sound0 = 0; sound1 = 4; end
                5: begin led = 12'b000000011111; sound0 = 0; sound1 = 5; end
                6: begin led = 12'b000000111111; sound0 = 0; sound1 = 6; end
                7: begin led = 12'b000001111111; sound0 = 0; sound1 = 7; end
                8: begin led = 12'b000011111111; sound0 = 0; sound1 = 8; end
                9: begin led = 12'b000111111111; sound0 = 0; sound1 = 9; end
                10:begin led = 12'b001111111111; sound0 = 1; sound1 = 0; end
                11:begin led = 12'b011111111111; sound0 = 1; sound1 = 1; end
                12:begin led = 12'b111111111111; sound0 = 1; sound1 = 2; end
                13:begin led = 12'b111111111111; sound0 = 1; sound1 = 2; end //buffer states incase of overflow
                14:begin led = 12'b111111111111; sound0 = 1; sound1 = 2; end
                
           endcase
           maxVol <= 0;
        end
        
    end
    assign LED = led;
    assign SOUND0 = sound0;
    assign SOUND1 = sound1;
    
endmodule