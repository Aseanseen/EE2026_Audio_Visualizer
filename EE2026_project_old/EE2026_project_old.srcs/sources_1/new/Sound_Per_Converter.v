`timescale 1ns / 1ps
/**
 * Sound Percentage Converter
 * Converts at a rate of 1 Hz
 */

module Sound_Per_Converter(
    input wave_sample_raw, clk_wire, 
    output reg [3:0] PERCENT0, reg [3:0] PERCENT1, reg [3:0] PERCENT2);
    
    reg [15:0] counter = 0;
    reg [15:0] counter1Hz = 1;
    reg [15:0] counter5Hz = 1;
    
    reg [11:0] percent0;
    reg [11:0] percent1;
    reg [11:0] percent2;
    
    always @ (posedge clk_wire) begin
        counter1Hz <= (counter1Hz > 20000 ? 0 : counter1Hz + 1); //1 Hz reset
        counter5Hz <= (counter1Hz > 4000 ? 0 : counter5Hz + 1); //5Hz reset
        counter <= (counter5Hz == 0 ? counter + wave_sample_raw / 200 : counter);
        
        if (counter1Hz == 0) begin
            percent0 <= (counter > 98 ? 1 : 0);
            percent1 <= (counter / 10);
            percent2 <= (counter % 10);
            
            PERCENT0 <= percent0;
            PERCENT1 <= percent1;
            PERCENT2 <= percent2;
        end
        
        
    
    end
    
    
endmodule
