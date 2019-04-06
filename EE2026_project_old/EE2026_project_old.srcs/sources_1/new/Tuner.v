`timescale 1ns / 1ps
/**
 * Feature++
 * Musical Tuner (Works well for high pitch tones)
 * Compares the current frequency, and outputs a note from A4 to G7
 * Also outputs if it is on the higher or lower range for that note
 */
module Tuner(input CLOCK, [13:0] freq100Hz, [5:0] mode, 
    output [5:0] WORD0, [5:0] WORD1, [5:0] WORD2, [5:0] WORD3
    );
    
    reg [5:0] word0;
    reg [5:0] word1;
    reg [5:0] word2;
    reg [5:0] word3;
    
    reg [5:0] counter = 0;
    
    //wires for range of notes
    //A4 - G4
    //wire A4 = ((freq100Hz >= 210) && (freq100Hz <= 235));
    //wire B4 = ((freq100Hz >= 236) && (freq100Hz <= 252));
    //wire C4 = ((freq100Hz >= 253) && (freq100Hz <= 280));
    //wire D4 = ((freq100Hz >= 281) && (freq100Hz <= 320));
    //wire E4 = ((freq100Hz >= 321) && (freq100Hz <= 340));
    //wire F4 = ((freq100Hz >= 341) && (freq100Hz <= 370));
    //wire G4 = ((freq100Hz >= 371) && (freq100Hz <= 420));
    
    wire A3L = ((freq100Hz >= 210) && (freq100Hz <= 216));
    wire A3  = ((freq100Hz >= 217) && (freq100Hz <= 228));
    wire A3H = ((freq100Hz >= 228) && (freq100Hz <= 235));
    wire B3L = ((freq100Hz >= 236) && (freq100Hz <= 240));
    wire B3  = ((freq100Hz >= 241) && (freq100Hz <= 247));
    wire B3H = ((freq100Hz >= 248) && (freq100Hz <= 252));
    wire C4L = ((freq100Hz >= 253) && (freq100Hz <= 262));
    wire C4  = ((freq100Hz >= 263) && (freq100Hz <= 273));
    wire C4H = ((freq100Hz >= 274) && (freq100Hz <= 280));
    wire D4L = ((freq100Hz >= 281) && (freq100Hz <= 290));
    wire D4  = ((freq100Hz >= 291) && (freq100Hz <= 309));
    wire D4H = ((freq100Hz >= 310) && (freq100Hz <= 320));
    wire E4L = ((freq100Hz >= 321) && (freq100Hz <= 326));
    wire E4  = ((freq100Hz >= 327) && (freq100Hz <= 333));
    wire E4H = ((freq100Hz >= 334) && (freq100Hz <= 340));
    wire F4L = ((freq100Hz >= 341) && (freq100Hz <= 350));
    wire F4  = ((freq100Hz >= 351) && (freq100Hz <= 363));
    wire F4H = ((freq100Hz >= 364) && (freq100Hz <= 370));
    wire G4L = ((freq100Hz >= 371) && (freq100Hz <= 383));
    wire G4  = ((freq100Hz >= 382) && (freq100Hz <= 413));
    wire G4H = ((freq100Hz >= 414) && (freq100Hz <= 420));
    
    //A5 - G5
    //wire A5 = ((freq100Hz >= 421) && (freq100Hz <= 470));
    //wire B5 = ((freq100Hz >= 471) && (freq100Hz <= 500));
    //wire C5 = ((freq100Hz >= 501) && (freq100Hz <= 550));
    //wire D5 = ((freq100Hz >= 551) && (freq100Hz <= 630));
    //wire E5 = ((freq100Hz >= 631) && (freq100Hz <= 680));
    //wire F5 = ((freq100Hz >= 681) && (freq100Hz <= 750));
    //wire G5 = ((freq100Hz >= 751) && (freq100Hz <= 840));
    
    wire A4L = ((freq100Hz >= 421) && (freq100Hz <= 435));
    wire A4  = ((freq100Hz >= 436) && (freq100Hz <= 455));
    wire A4H = ((freq100Hz >= 456) && (freq100Hz <= 470));
    wire B4L = ((freq100Hz >= 471) && (freq100Hz <= 478));
    wire B4  = ((freq100Hz >= 479) && (freq100Hz <= 491));
    wire B4H = ((freq100Hz >= 492) && (freq100Hz <= 500));
    wire C5L = ((freq100Hz >= 501) && (freq100Hz <= 510));
    wire C5  = ((freq100Hz >= 511) && (freq100Hz <= 539));
    wire C5H = ((freq100Hz >= 540) && (freq100Hz <= 550));
    wire D5L = ((freq100Hz >= 551) && (freq100Hz <= 571));
    wire D5  = ((freq100Hz >= 572) && (freq100Hz <= 611));
    wire D5H = ((freq100Hz >= 612) && (freq100Hz <= 630));
    wire E5L = ((freq100Hz >= 631) && (freq100Hz <= 644));
    wire E5  = ((freq100Hz >= 645) && (freq100Hz <= 674));
    wire E5H = ((freq100Hz >= 675) && (freq100Hz <= 680));
    wire F5L = ((freq100Hz >= 681) && (freq100Hz <= 701));
    wire F5  = ((freq100Hz >= 712) && (freq100Hz <= 731));
    wire F5H = ((freq100Hz >= 732) && (freq100Hz <= 750));
    wire G5L = ((freq100Hz >= 751) && (freq100Hz <= 780));
    wire G5  = ((freq100Hz >= 781) && (freq100Hz <= 810));
    wire G5H = ((freq100Hz >= 811) && (freq100Hz <= 840));
    
    //A6 - G6
    //wire A6 = ((freq100Hz >= 841) && (freq100Hz <= 940));
    //wire B6 = ((freq100Hz >= 941) && (freq100Hz <= 1010));
    //wire C6 = ((freq100Hz >= 1011) && (freq100Hz <= 1100));
    //wire D6 = ((freq100Hz >= 1101) && (freq100Hz <= 1220));
    //wire E6 = ((freq100Hz >= 1221) && (freq100Hz <= 1340));
    //wire F6 = ((freq100Hz >= 1341) && (freq100Hz <= 1450));
    //wire G6 = ((freq100Hz >= 1451) && (freq100Hz <= 1650));
    
    wire A5L = ((freq100Hz >= 841) && (freq100Hz <= 870));
    wire A5  = ((freq100Hz >= 871) && (freq100Hz <= 910));
    wire A5H = ((freq100Hz >= 911) && (freq100Hz <= 940));
    wire B5L = ((freq100Hz >= 941) && (freq100Hz <= 960));
    wire B5  = ((freq100Hz >= 961) && (freq100Hz <= 990));
    wire B5H = ((freq100Hz >= 991) && (freq100Hz <= 1010));
    wire C6L = ((freq100Hz >= 1011) && (freq100Hz <= 1040));
    wire C6  = ((freq100Hz >= 1041) && (freq100Hz <= 1070));
    wire C6H = ((freq100Hz >= 1071) && (freq100Hz <= 1100));
    wire D6L = ((freq100Hz >= 1101) && (freq100Hz <= 1140));
    wire D6  = ((freq100Hz >= 1141) && (freq100Hz <= 1180));
    wire D6H = ((freq100Hz >= 1181) && (freq100Hz <= 1220));
    wire E6L = ((freq100Hz >= 1221) && (freq100Hz <= 1260));
    wire E6  = ((freq100Hz >= 1261) && (freq100Hz <= 1300));
    wire E6H = ((freq100Hz >= 1301) && (freq100Hz <= 1340));
    wire F6L = ((freq100Hz >= 1341) && (freq100Hz <= 1375));
    wire F6  = ((freq100Hz >= 1376) && (freq100Hz <= 1405));
    wire F6H = ((freq100Hz >= 1406) && (freq100Hz <= 1450));
    wire G6L = ((freq100Hz >= 1451) && (freq100Hz <= 1510));
    wire G6  = ((freq100Hz >= 1511) && (freq100Hz <= 1570));
    wire G6H = ((freq100Hz >= 1571) && (freq100Hz <= 1650));
    
    //A7 - G7
    //wire A7 = ((freq100Hz >= 1651) && (freq100Hz <= 1850));
    //wire B7 = ((freq100Hz >= 1851) && (freq100Hz <= 2030));
    //wire C7 = ((freq100Hz >= 2031) && (freq100Hz <= 2250));
    //wire D7 = ((freq100Hz >= 2251) && (freq100Hz <= 2500));
    //wire E7 = ((freq100Hz >= 2501) && (freq100Hz <= 2650));
    //wire F7 = ((freq100Hz >= 2651) && (freq100Hz <= 2850));
    //wire G7 = ((freq100Hz >= 2851) && (freq100Hz <= 3250));
    
    wire A6L = ((freq100Hz >= 1651) && (freq100Hz <= 1710));
    wire A6  = ((freq100Hz >= 1711) && (freq100Hz <= 1780));
    wire A6H = ((freq100Hz >= 1781) && (freq100Hz <= 1850));
    wire B6L = ((freq100Hz >= 1851) && (freq100Hz <= 1910));
    wire B6  = ((freq100Hz >= 1911) && (freq100Hz <= 1970));
    wire B6H = ((freq100Hz >= 1971) && (freq100Hz <= 2030));
    wire C7L = ((freq100Hz >= 2031) && (freq100Hz <= 2100));
    wire C7  = ((freq100Hz >= 2101) && (freq100Hz <= 2180));
    wire C7H = ((freq100Hz >= 2181) && (freq100Hz <= 2250));
    wire D7L = ((freq100Hz >= 2251) && (freq100Hz <= 2320));
    wire D7  = ((freq100Hz >= 2321) && (freq100Hz <= 2430));
    wire D7H = ((freq100Hz >= 2431) && (freq100Hz <= 2500));
    wire E7L = ((freq100Hz >= 2501) && (freq100Hz <= 2550));
    wire E7  = ((freq100Hz >= 2551) && (freq100Hz <= 2600));
    wire E7H = ((freq100Hz >= 2601) && (freq100Hz <= 2650));
    wire F7L = ((freq100Hz >= 2651) && (freq100Hz <= 2710));
    wire F7  = ((freq100Hz >= 2711) && (freq100Hz <= 2790));
    wire F7H = ((freq100Hz >= 2791) && (freq100Hz <= 2850));
    wire G7L = ((freq100Hz >= 2851) && (freq100Hz <= 2950));
    wire G7  = ((freq100Hz >= 2951) && (freq100Hz <= 3150));
    wire G7H = ((freq100Hz >= 3151) && (freq100Hz <= 3250));

    always @ (posedge CLOCK) begin
        counter <= (counter >= 100 ? 0 : counter + 1); //1Hz
        
        if (counter == 0) begin //17 40
            if (A3L) begin word0 = 17; word1 = 40; word2 = 10; word3 = 3; end
            if (A3 ) begin word0 = 40; word1 = 40; word2 = 10; word3 = 3; end
            if (A3H) begin word0 = 21; word1 = 40; word2 = 10; word3 = 3; end
            if (B3L) begin word0 = 17; word1 = 40; word2 = 11; word3 = 3; end
            if (B3 ) begin word0 = 40; word1 = 40; word2 = 11; word3 = 3; end
            if (B3H) begin word0 = 21; word1 = 40; word2 = 11; word3 = 3; end
            if (C4L) begin word0 = 17; word1 = 40; word2 = 12; word3 = 4; end
            if (C4 ) begin word0 = 40; word1 = 40; word2 = 12; word3 = 4; end
            if (C4H) begin word0 = 21; word1 = 40; word2 = 12; word3 = 4; end
            if (D4L) begin word0 = 17; word1 = 40; word2 = 13; word3 = 4; end
            if (D4 ) begin word0 = 40; word1 = 40; word2 = 13; word3 = 4; end
            if (D4H) begin word0 = 21; word1 = 40; word2 = 13; word3 = 4; end
            if (E4L) begin word0 = 17; word1 = 40; word2 = 14; word3 = 4; end
            if (E4 ) begin word0 = 40; word1 = 40; word2 = 14; word3 = 4; end
            if (E4H) begin word0 = 21; word1 = 40; word2 = 14; word3 = 4; end
            if (F4L) begin word0 = 17; word1 = 40; word2 = 15; word3 = 4; end
            if (F4 ) begin word0 = 40; word1 = 40; word2 = 15; word3 = 4; end
            if (F4H) begin word0 = 21; word1 = 40; word2 = 15; word3 = 4; end
            if (G4L) begin word0 = 17; word1 = 40; word2 = 16; word3 = 4; end
            if (G4 ) begin word0 = 40; word1 = 40; word2 = 16; word3 = 4; end
            if (G4H) begin word0 = 21; word1 = 40; word2 = 16; word3 = 4; end
            
            if (A4L) begin word0 = 17; word1 = 40; word2 = 10; word3 = 4; end
            if (A4 ) begin word0 = 40; word1 = 40; word2 = 10; word3 = 4; end
            if (A4H) begin word0 = 21; word1 = 40; word2 = 10; word3 = 4; end
            if (B4L) begin word0 = 17; word1 = 40; word2 = 11; word3 = 4; end
            if (B4 ) begin word0 = 40; word1 = 40; word2 = 11; word3 = 4; end
            if (B4H) begin word0 = 21; word1 = 40; word2 = 11; word3 = 4; end
            if (C5L) begin word0 = 17; word1 = 40; word2 = 12; word3 = 5; end
            if (C5 ) begin word0 = 40; word1 = 40; word2 = 12; word3 = 5; end
            if (C5H) begin word0 = 21; word1 = 40; word2 = 12; word3 = 5; end
            if (D5L) begin word0 = 17; word1 = 40; word2 = 13; word3 = 5; end
            if (D5 ) begin word0 = 40; word1 = 40; word2 = 13; word3 = 5; end
            if (D5H) begin word0 = 21; word1 = 40; word2 = 13; word3 = 5; end
            if (E5L) begin word0 = 17; word1 = 40; word2 = 14; word3 = 5; end
            if (E5 ) begin word0 = 40; word1 = 40; word2 = 14; word3 = 5; end
            if (E5H) begin word0 = 21; word1 = 40; word2 = 14; word3 = 5; end
            if (F5L) begin word0 = 17; word1 = 40; word2 = 15; word3 = 5; end
            if (F5 ) begin word0 = 40; word1 = 40; word2 = 15; word3 = 5; end
            if (F5H) begin word0 = 21; word1 = 40; word2 = 15; word3 = 5; end
            if (G5L) begin word0 = 17; word1 = 40; word2 = 16; word3 = 5; end
            if (G5 ) begin word0 = 40; word1 = 40; word2 = 16; word3 = 5; end
            if (G5H) begin word0 = 21; word1 = 40; word2 = 16; word3 = 5; end
            
            if (A5L) begin word0 = 17; word1 = 40; word2 = 10; word3 = 5; end
            if (A5 ) begin word0 = 40; word1 = 40; word2 = 10; word3 = 5; end
            if (A5H) begin word0 = 21; word1 = 40; word2 = 10; word3 = 5; end
            if (B5L) begin word0 = 17; word1 = 40; word2 = 11; word3 = 5; end
            if (B5 ) begin word0 = 40; word1 = 40; word2 = 11; word3 = 5; end
            if (B5H) begin word0 = 21; word1 = 40; word2 = 11; word3 = 5; end
            if (C6L) begin word0 = 17; word1 = 40; word2 = 12; word3 = 6; end
            if (C6 ) begin word0 = 40; word1 = 40; word2 = 12; word3 = 6; end
            if (C6H) begin word0 = 21; word1 = 40; word2 = 12; word3 = 6; end
            if (D6L) begin word0 = 17; word1 = 40; word2 = 13; word3 = 6; end
            if (D6 ) begin word0 = 40; word1 = 40; word2 = 13; word3 = 6; end
            if (D6H) begin word0 = 21; word1 = 40; word2 = 13; word3 = 6; end
            if (E6L) begin word0 = 17; word1 = 40; word2 = 14; word3 = 6; end
            if (E6 ) begin word0 = 40; word1 = 40; word2 = 14; word3 = 6; end
            if (E6H) begin word0 = 21; word1 = 40; word2 = 14; word3 = 6; end
            if (F6L) begin word0 = 17; word1 = 40; word2 = 15; word3 = 6; end
            if (F6 ) begin word0 = 40; word1 = 40; word2 = 15; word3 = 6; end
            if (F6H) begin word0 = 21; word1 = 40; word2 = 15; word3 = 6; end
            if (G6L) begin word0 = 17; word1 = 40; word2 = 16; word3 = 6; end
            if (G6 ) begin word0 = 40; word1 = 40; word2 = 16; word3 = 6; end
            if (G6H) begin word0 = 21; word1 = 40; word2 = 16; word3 = 6; end
            
            if (A6L) begin word0 = 17; word1 = 40; word2 = 10; word3 = 6; end
            if (A6 ) begin word0 = 40; word1 = 40; word2 = 10; word3 = 6; end
            if (A6H) begin word0 = 21; word1 = 40; word2 = 10; word3 = 6; end
            if (B6L) begin word0 = 17; word1 = 40; word2 = 11; word3 = 6; end
            if (B6 ) begin word0 = 40; word1 = 40; word2 = 11; word3 = 6; end
            if (B6H) begin word0 = 21; word1 = 40; word2 = 11; word3 = 6; end
            if (C7L) begin word0 = 17; word1 = 40; word2 = 12; word3 = 7; end
            if (C7 ) begin word0 = 40; word1 = 40; word2 = 12; word3 = 7; end
            if (C7H) begin word0 = 21; word1 = 40; word2 = 12; word3 = 7; end
            if (D7L) begin word0 = 17; word1 = 40; word2 = 13; word3 = 7; end
            if (D7 ) begin word0 = 40; word1 = 40; word2 = 13; word3 = 7; end
            if (D7H) begin word0 = 21; word1 = 40; word2 = 13; word3 = 7; end
            if (E7L) begin word0 = 17; word1 = 40; word2 = 14; word3 = 7; end
            if (E7 ) begin word0 = 40; word1 = 40; word2 = 14; word3 = 7; end
            if (E7H) begin word0 = 21; word1 = 40; word2 = 14; word3 = 7; end
            if (F7L) begin word0 = 17; word1 = 40; word2 = 15; word3 = 7; end
            if (F7 ) begin word0 = 40; word1 = 40; word2 = 15; word3 = 7; end
            if (F7H) begin word0 = 21; word1 = 40; word2 = 15; word3 = 7; end
            if (G7L) begin word0 = 17; word1 = 40; word2 = 16; word3 = 7; end
            if (G7 ) begin word0 = 40; word1 = 40; word2 = 16; word3 = 7; end
            if (G7H) begin word0 = 21; word1 = 40; word2 = 16; word3 = 7; end
            
        end
    
    end
    
    
    assign WORD0 = word0;
    assign WORD1 = word1;
    assign WORD2 = word2;
    assign WORD3 = word3;
    
endmodule
