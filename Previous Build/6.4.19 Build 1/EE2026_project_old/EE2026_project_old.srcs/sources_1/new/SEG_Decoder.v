`timescale 1ns / 1ps
/**
 * SEG Decoder
 * Decoder prints out a set of 4 letters corresponding to WORD0 to WORD3
 * No scrolling feature
 */
module SEG_Decoder(input CLOCK, [5:0] WORD0, [5:0] WORD1, [5:0] WORD2, [5:0] WORD3, output [7:0] SEG, [3:0] AN);
    reg [28:0] COUNTER = 1;
    reg [1:0] STATE = 0;
    reg [7:0] seg; //seg display state
    reg [3:0] an; //an display
    reg [5:0] PRINT; //alphanumeric to print
    
    always @ (posedge CLOCK) begin
        //freq to print out letters
        COUNTER <= (COUNTER >= 29'b11111110010100000010101011000 ? 0 : COUNTER + 2048);
        STATE <= (COUNTER == 0 ? (STATE + 1) % 4 : STATE); //which AN to display
        
        case (STATE) //set AN display
            0: begin an = 4'b0111; PRINT = WORD0; end 
            1: begin an = 4'b1011; PRINT = WORD1; end 
            2: begin an = 4'b1101; PRINT = WORD2; end 
            3: begin an = 4'b1110; PRINT = WORD3; end
        endcase
        
        //alphanumeric decoder, 0 - 9 (numbers), 10 - 26 (alphabets)
        case (PRINT)     //8'b.gfedcba;
            0: begin seg = 8'b11000000; end //0
            1: begin seg = 8'b11111001; end //1
            2: begin seg = 8'b10100100; end //2
            3: begin seg = 8'b10110000; end //3
            4: begin seg = 8'b10011001; end //4
            5: begin seg = 8'b10010010; end //5
            6: begin seg = 8'b10000010; end //6
            7: begin seg = 8'b11111000; end //7
            8: begin seg = 8'b10000000; end //8
            9: begin seg = 8'b10010000; end //9
                          //8'b.gfedcba;
            10: begin seg = 8'b10001000; end //A
            11: begin seg = 8'b10000011; end //B
            12: begin seg = 8'b11000110; end //C
            13: begin seg = 8'b10100001; end //D
            14: begin seg = 8'b10000110; end //E
            15: begin seg = 8'b10001110; end //F
            16: begin seg = 8'b10000010; end //G
            17: begin seg = 8'b10001001; end //H
            18: begin seg = 8'b10000110; end //I
            19: begin seg = 8'b11100001; end //J
                          //8'b.gfedcba;
            20: begin seg = 8'b10001001; end //K
            21: begin seg = 8'b11000111; end //L
            22: begin seg = 8'b11101010; end //M
            23: begin seg = 8'b10101011; end //N
            24: begin seg = 8'b11000000; end //O
            25: begin seg = 8'b10001100; end //P
            26: begin seg = 8'b10010000; end //Q
            27: begin seg = 8'b10101111; end //R
            28: begin seg = 8'b10010010; end //S
            29: begin seg = 8'b10000111; end //T
                          //8'b.gfedcba;
            30: begin seg = 8'b11100011; end //U
            31: begin seg = 8'b11100011; end //V
            32: begin seg = 8'b11010101; end //W
            33: begin seg = 8'b10001001; end //X
            34: begin seg = 8'b10010001; end //Y
            35: begin seg = 8'b10100100; end //Z
            36: begin seg = 8'b01111111; end //.
            37: begin seg = 8'b00101101; end //%
            40: begin seg = 8'b11111111; end //NULL
        endcase
        
        
        
    end  
    
    assign SEG = seg;
    assign AN = an;

endmodule
