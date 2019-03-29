`timescale 1ns / 1ps
/**
 */

module Freq_Counter(input CLOCK, clk_wire, [11:0] wave_sample_raw, 
    output reg [11:0] FREQ = 0, reg [3:0] FREQ0, reg [3:0] FREQ1, reg [3:0] FREQ2, reg [3:0] FREQ3);
    reg [11:0] prev = 2048;
    reg [11:0] counter = 0;
    reg [15:0] counter1Hz = 1;
    
    reg [11:0] freq0;
    reg [11:0] freq1;
    reg [11:0] freq2;
    reg [11:0] freq3;
    
    always @ (posedge clk_wire) begin //20k Hz clock
        counter1Hz <= (counter1Hz > 20000 ? 0 : counter1Hz + 1); //1 Hz reset
        
        //count crossings per 1s, hard capped at 5k
        counter <= (wave_sample_raw > 2048 && prev < 2048 ? (counter >= 5000 ? counter : counter + 1) : counter);
        
        if(counter1Hz == 0) begin //update every 1Hz
            FREQ <= counter;
            counter <= (counter1Hz == 0 ? 0 : counter); //reset
            
            
            freq0 <= FREQ / 1000;
            freq1 <= (FREQ % 1000) / 100;
            freq2 <= (FREQ % 100) / 10;
            freq3 <= FREQ % 10;
            
            FREQ0 <= freq0;
            FREQ1 <= freq1;
            FREQ2 <= freq2;
            FREQ3 <= freq3;
            
        end
        
        prev = wave_sample_raw; //update prev
        
    end
    
endmodule
