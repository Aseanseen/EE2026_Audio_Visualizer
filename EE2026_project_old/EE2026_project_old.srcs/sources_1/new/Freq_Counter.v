`timescale 1ns / 1ps
/**
 */

module Freq_Counter(input CLOCK, clk_wire, [13:0] wave_sample_raw, 
    output reg [13:0] FREQ = 0, reg [13:0] FREQ100HZ, reg [3:0] FREQ0, reg [3:0] FREQ1, reg [3:0] FREQ2, reg [3:0] FREQ3);
    reg [11:0] prev = 2048; //prev wave_sample value
    
    reg [13:0] counter = 0; //num of crossings
    
    reg [15:0] counter100Hz = 1; //clock counters
    reg [15:0] counter2Hz = 1;
    
    reg [11:0] freq100Hz; //dynamic 100Hz refresh rate
    reg [11:0] freq; //regular .5Hz
    
    reg [11:0] freq0; //for display in 7SEG
    reg [11:0] freq1;
    reg [11:0] freq2;
    reg [11:0] freq3;
	
	reg [11:0] memory[99:0];
	
    always @ (posedge clk_wire) begin //20k Hz clock
        counter100Hz <= (counter100Hz > 199 ? 0 : counter100Hz + 1); //100 Hz
        counter2Hz <= (counter2Hz > 9999 ? 0 : counter2Hz + 1); //100 Hz
        
        counter <= (wave_sample_raw > 2048 && prev < 2048 ? (counter >= 5000 ? counter : counter + 1) : counter);
        
        if (counter2Hz == 0) begin
            //freq <= freq100Hz;
            FREQ <= freq100Hz;
                         
            freq0 <= FREQ / 1000;
            freq1 <= (FREQ % 1000) / 100;
            freq2 <= (FREQ % 100) / 10;
            freq3 <= FREQ % 10;
            
            FREQ0 <= freq0;
            FREQ1 <= freq1;
            FREQ2 <= freq2;
            FREQ3 <= freq3;
            
        end
        
        if(counter100Hz == 0) begin //update every 1Hz
			memory[98] <= memory[99];
			memory[97] <= memory[98];
			memory[96] <= memory[97];
			memory[95] <= memory[96];
			memory[94] <= memory[95];
			memory[93] <= memory[94];
			memory[92] <= memory[93];
			memory[91] <= memory[92];
			memory[90] <= memory[91];
			memory[89] <= memory[90];
			memory[88] <= memory[89];
			memory[87] <= memory[88];
			memory[86] <= memory[87];
			memory[85] <= memory[86];
			memory[84] <= memory[85];
			memory[83] <= memory[84];
			memory[82] <= memory[83];
			memory[81] <= memory[82];
			memory[80] <= memory[81];
			memory[79] <= memory[80];
			memory[78] <= memory[79];
			memory[77] <= memory[78];
			memory[76] <= memory[77];
			memory[75] <= memory[76];
			memory[74] <= memory[75];
			memory[73] <= memory[74];
			memory[72] <= memory[73];
			memory[71] <= memory[72];
			memory[70] <= memory[71];
			memory[69] <= memory[70];
			memory[68] <= memory[69];
			memory[67] <= memory[68];
			memory[66] <= memory[67];
			memory[65] <= memory[66];
			memory[64] <= memory[65];
			memory[63] <= memory[64];
			memory[62] <= memory[63];
			memory[61] <= memory[62];
			memory[60] <= memory[61];
			memory[59] <= memory[60];
			memory[58] <= memory[59];
			memory[57] <= memory[58];
			memory[56] <= memory[57];
			memory[55] <= memory[56];
			memory[54] <= memory[55];
			memory[53] <= memory[54];
			memory[52] <= memory[53];
			memory[51] <= memory[52];
			memory[50] <= memory[51];
			memory[49] <= memory[50];
			memory[48] <= memory[49];
			memory[47] <= memory[48];
			memory[46] <= memory[47];
			memory[45] <= memory[46];
			memory[44] <= memory[45];
			memory[43] <= memory[44];
			memory[42] <= memory[43];
			memory[41] <= memory[42];
			memory[40] <= memory[41];
			memory[39] <= memory[40];
			memory[38] <= memory[39];
			memory[37] <= memory[38];
			memory[36] <= memory[37];
			memory[35] <= memory[36];
			memory[34] <= memory[35];
			memory[33] <= memory[34];
			memory[32] <= memory[33];
			memory[31] <= memory[32];
			memory[30] <= memory[31];
			memory[29] <= memory[30];
			memory[28] <= memory[29];
			memory[27] <= memory[28];
			memory[26] <= memory[27];
			memory[25] <= memory[26];
			memory[24] <= memory[25];
			memory[23] <= memory[24];
			memory[22] <= memory[23];
			memory[21] <= memory[22];
			memory[20] <= memory[21];
			memory[19] <= memory[20];
			memory[18] <= memory[19];
			memory[17] <= memory[18];
			memory[16] <= memory[17];
			memory[15] <= memory[16];
			memory[14] <= memory[15];
			memory[13] <= memory[14];
			memory[12] <= memory[13];
			memory[11] <= memory[12];
			memory[10] <= memory[11];
			memory[9] <= memory[10];
			memory[8] <= memory[9];
			memory[7] <= memory[8];
			memory[6] <= memory[7];
			memory[5] <= memory[6];
			memory[4] <= memory[5];
			memory[3] <= memory[4];
			memory[2] <= memory[3];
			memory[1] <= memory[2];
			memory[0] <= memory[1];
			
			memory[99] <= counter;
			
			freq100Hz <=  
			memory[99] + memory[98] + memory[97] + memory[96] + memory[95] +
            memory[94] + memory[93] + memory[92] + memory[91] + memory[90] +
            memory[89] + memory[88] + memory[87] + memory[86] + memory[85] +
            memory[84] + memory[83] + memory[82] + memory[81] + memory[80] +
            memory[79] + memory[78] + memory[77] + memory[76] + memory[75] +
            memory[74] + memory[73] + memory[72] + memory[71] + memory[70] +
            memory[69] + memory[68] + memory[67] + memory[66] + memory[65] +
            memory[64] + memory[63] + memory[62] + memory[61] + memory[60] +
            memory[59] + memory[58] + memory[57] + memory[56] + memory[55] +
            memory[54] + memory[53] + memory[52] + memory[51] + memory[50] +
            memory[49] + memory[48] + memory[47] + memory[46] + memory[45] +
            memory[44] + memory[43] + memory[42] + memory[41] + memory[40] +
            memory[39] + memory[38] + memory[37] + memory[36] + memory[35] +
            memory[34] + memory[33] + memory[32] + memory[31] + memory[30] +
            memory[29] + memory[28] + memory[27] + memory[26] + memory[25] +
            memory[24] + memory[23] + memory[22] + memory[21] + memory[20] +
            memory[19] + memory[18] + memory[17] + memory[16] + memory[15] +
            memory[14] + memory[13] + memory[12] + memory[11] + memory[10] +
            memory[9] + memory[8] + memory[7] + memory[6] + memory[5] +
            memory[4] + memory[3] + memory[2] + memory[1] + memory[0];
			
            counter <= (counter100Hz == 0 ? 0 : counter); //reset
			FREQ100HZ <= freq100Hz;
        end
        
        prev = wave_sample_raw; //update prev
        
    end
    
endmodule