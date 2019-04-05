`timescale 1ns / 1ps
/**
 * Mode Selector
 * Handles different mode switching via btnU and btnD
 * Changing of options is done via btnL and btnR
 */
module Mode_Selector(
    input CLOCK, clk_wire, clk_30Hz, wave_sample_raw,
    btnC, btnU, btnD, btnL, btnR, 
    [5:0] SEG_VOL0, [5:0] SEG_VOL1, 
    [3:0] FREQ0, [3:0] FREQ1,  [3:0] FREQ2, [3:0] FREQ3, 
    [5:0] SPERCENT0, [5:0] SPERCENT1, [5:0] SPERCENT2,
    MOUSELEFT, [11:0] MOUSEX, [11:0] MOUSEY,
    output [7:0] SEG, [3:0] AN, [5:0] MODE, [2:0] WAVEMODE, 
    [2:0] CLRSTATE, [2:0] WAVEFORMSTATE, [2:0] HISTSTATE, [2:0] CIRCLESTATE, 
    LOCK);
    
    wire USTATE; //state of button up
    wire DSTATE; //state of button down
    wire LSTATE; //state of button left
    wire RSTATE; //state of button right
    wire CSTATE; //state of button center
    
    reg lock = 0; //locking reg
    reg [5:0] option = 1; //num in option selector
    
    wire [5:0] WORD0; //words to print in decoder
    wire [5:0] WORD1;
    wire [5:0] WORD2;
    wire [5:0] WORD3;
    
    reg [5:0] word0; //temp assign to word
    reg [5:0] word1;
    reg [5:0] word2;
    reg [5:0] word3;
    
    reg [5:0] mode = 1;
    reg [2:0] clrState = 1; //state of color display options
    reg [2:0] clrPrev = 1;
    
    //state of parameter displays
    reg [2:0] displayState = 1;
    reg [29:0] display1Hz = 0; //parameter menu word displays (1 sec)
    
    //which waveform to display
    reg [2:0] waveMode = 1;
    reg [2:0] waveModePrev = 1;
    
    //state of waveform display
    reg [2:0] waveformState = 1;
    reg [2:0] waveformPrev = 1;
    
    //state of waveform history display
    reg [2:0] histState = 1;
    reg [2:0] histPrev = 1;
    
    //state of circle waveform display
    reg [2:0] circleState = 1;
    reg [2:0] circlePrev = 1;
    
    //mouse last state
    reg mouseLastState = 0;
    
    Button_Pulser up(clk_30Hz, btnU, USTATE); //single pulser for button presses
    Button_Pulser down(clk_30Hz, btnD, DSTATE);
    Button_Pulser left(clk_30Hz, btnL, LSTATE);                                      
    Button_Pulser right(clk_30Hz, btnR, RSTATE);
    Button_Pulser ctr(clk_30Hz, btnC, CSTATE);
    
    SEG_Decoder seg_d(CLOCK, WORD0, WORD1, WORD2, WORD3, SEG, AN);
    
    always @ (posedge clk_30Hz) begin
    
        //buttons on display
        if (MOUSELEFT && ~mouseLastState) begin
            //Color Selector
            if (MOUSEX >= 1220 && MOUSEX < 1265 && MOUSEY >= 868 && MOUSEY < 894) begin
                clrState <= 1;
                clrPrev <= 1;
            end
            
            else if (MOUSEX >= 1220 && MOUSEX < 1265 && MOUSEY >= 898 && MOUSEY < 924) begin
                clrState <= 2;
                clrPrev <= 2;
            end
            
            else if (MOUSEX >= 1220 && MOUSEX < 1265 && MOUSEY >= 928 && MOUSEY < 954) begin
                clrState <= 3;
                clrPrev <= 3;
            end
            
            else if (MOUSEX >= 1220 && MOUSEX < 1265 && MOUSEY >= 958 && MOUSEY < 984) begin
                clrState <= 4;
                clrPrev <= 4;
            end
            
            else if (MOUSEX >= 1220 && MOUSEX < 1265 && MOUSEY >= 988 && MOUSEY < 1014) begin
                clrState <= 5;
                clrPrev <= 5;
            end
            
            //MODES
            //wave
            //wave norm
            else if (MOUSEX >= 15 && MOUSEX < 60 && MOUSEY >= 898 && MOUSEY < 924) begin
                waveMode <= 1;
                waveModePrev <= 1;
                waveformState <= 1;
                waveformPrev <= 1;
            end
            
            //wave fill
            else if (MOUSEX >= 15 && MOUSEX < 60 && MOUSEY >= 928 && MOUSEY < 954) begin
                waveMode <= 1;
                waveModePrev <= 1;
                waveformState <= 2;
                waveformPrev <= 2;
            end
            
            //wave bar
            else if (MOUSEX >= 15 && MOUSEX < 60 && MOUSEY >= 958 && MOUSEY < 984) begin
                waveMode <= 1;
                waveModePrev <= 1;
                waveformState <= 3;
                waveformPrev <= 3;
            end
            
            //wave block
            else if (MOUSEX >= 15 && MOUSEX < 60 && MOUSEY >= 988 && MOUSEY < 1014) begin
                waveMode <= 1;
                waveModePrev <= 1;
                waveformState <= 4;
                waveformPrev <= 4;
            end
            
            //hist
            //hist vol
            if (MOUSEX >= 80 && MOUSEX < 125 && MOUSEY >= 898 && MOUSEY < 924) begin
                waveMode <= 2;
                waveModePrev <= 2;
                histState <= 1;
                histPrev <= 1;
            end
            //hist freq
            else if (MOUSEX >= 80 && MOUSEX < 125 && MOUSEY >= 928 && MOUSEY < 954) begin
                waveMode <= 2;
                waveModePrev <= 2;
                histState <= 2;
                histPrev <= 2;
            end
            //hist nyannn
            else if (MOUSEX >= 80 && MOUSEX < 125 && MOUSEY >= 958 && MOUSEY < 984) begin
                waveMode <= 2;
                waveModePrev <= 2;
                histState <= 3;
                histPrev <= 3;
            end
            
            //circ norm
            else if (MOUSEX >= 145 && MOUSEX < 190 && MOUSEY >= 898 && MOUSEY < 924) begin
                waveMode <= 3;
                waveModePrev <= 3;
                circleState <= 1;
                circlePrev <= 1;
            end
            //circ slow
            else if (MOUSEX >= 145 && MOUSEX < 190 && MOUSEY >= 928 && MOUSEY < 954) begin
                waveMode <= 3;
                waveModePrev <= 3;
                circleState <= 2;
                circlePrev <= 2;
            end
            //circ freq
            else if (MOUSEX >= 145 && MOUSEX < 190 && MOUSEY >= 958 && MOUSEY < 984) begin
                waveMode <= 3;
                waveModePrev <= 3;
                circleState <= 3;
                circlePrev <= 3;
            end
            //circ freq slow
            else if (MOUSEX >= 145 && MOUSEX < 190 && MOUSEY >= 988 && MOUSEY < 1014) begin
                waveMode <= 3;
                waveModePrev <= 3;
                circleState <= 4;
                circlePrev <= 4;
            end
        end
        
        //mode changing logic
        if (USTATE == 1 && ~btnD) begin //button press up
            mode <= (mode >= 6 ? mode : mode + 1);
            display1Hz = 0;
            option <= 1;
            
            //change back to original settings
            clrState <= clrPrev;
            waveformState <= waveformPrev;
            histState <= histPrev;
            circleState <= circlePrev;
        end
        
        if (DSTATE == 1 && ~btnU) begin //button press down
            mode <= (mode == 0 ? mode : mode - 1);
            display1Hz = 0;
            option <= 1;
            
            //change back to original settings
            clrState <= clrPrev;
            waveformState <= waveformPrev;
            histState <= histPrev;
            circleState <= circlePrev;
        end
        
        //lock waveform mode
        if (mode == 0) begin //set logic when btnC is pressed
            waveMode <= waveModePrev;
            if (CSTATE == 1) begin
                lock <= ~lock;
                mode <= 1; //switch back to base mode
            end
        end
        
        if (mode == 1) begin
            clrState <= clrPrev;
            waveMode <= waveModePrev;
            waveformState <= waveformPrev;
            histState <= histPrev;
            circleState <= circlePrev;
        end
        
        //parameter display mode
        if (LSTATE == 1 && ~btnR && mode == 2) begin //button press left
            displayState <= (displayState >= 2 ? displayState : displayState + 1);
            display1Hz = 0;
        end
        
        if (RSTATE == 1 && ~btnL && mode == 2) begin //button press right
            displayState <= (displayState == 1 ? displayState : displayState - 1);
            display1Hz = 0;
        end
        
        if (mode == 2) begin
            clrState <= clrPrev;
            waveMode <= waveModePrev;
            waveformState <= waveformPrev;
            histState <= histPrev;
            circleState <= circlePrev;
        end
        
        //parameter display counter, shows FREQ / VOL at the start
        display1Hz <= (display1Hz >= 61 ? display1Hz : display1Hz + 1);
        
        //color state mode
        if (LSTATE == 1 && ~btnR && mode == 3) begin //button press left
            option <= (option >= 5 ? option : option + 1);  
        end
        
        if (RSTATE == 1 && ~btnL && mode == 3) begin //button press right
            option <= (option == 1 ? option : option - 1);
        end
        
        if (mode == 3) begin //set logic when btnC is pressed
            clrState <= option;
            waveMode <= waveModePrev;
            waveformState <= waveformPrev;
            histState <= histPrev;
            circleState <= circlePrev;
            
            if (CSTATE == 1) begin
                clrState <= option;
                clrPrev <= option;
                option <= 1;
                mode <= 1;
            end
        end
        
        //waveform mode
        if (LSTATE == 1 && ~btnR && mode == 4) begin //button press left
            option <= (option >= 4 ? option : option + 1);
            display1Hz = 0;
        end
        
        if (RSTATE == 1 && ~btnL && mode == 4) begin //button press right
            option <= (option == 1 ? option : option - 1);
            display1Hz = 0;
        end
        
        if (mode == 4) begin //set logic when btnC is pressed
            waveformState <= option;
            waveMode <= 1;
            clrState <= clrPrev;
            histState <= histPrev;
            circleState <= circlePrev;
            
            if (CSTATE == 1) begin
                waveMode <= 1;
                waveModePrev <= 1;
                waveformState <= option;
                waveformPrev <= option;
                option <= 1;
                mode <= 1;
            end
        end
        
        //history mode
        if (LSTATE == 1 && ~btnR && mode == 5) begin //button press left
            option <= (option >= 3 ? option : option + 1);
            display1Hz = 0;
        end
        
        if (RSTATE == 1 && ~btnL && mode == 5) begin //button press right
            option <= (option == 1 ? option : option - 1);
            display1Hz = 0;
        end
        
        if (mode == 5) begin //set logic when btnC is pressed
            waveMode <= 2;
            waveformState <= waveformPrev;
            clrState <= clrPrev;
            histState <= option;
            circleState <= circlePrev;
            
            if (CSTATE == 1) begin
                waveMode <= 2;
                waveModePrev <= 2;
                histState <= option;
                histPrev <= option;
                option <= 1;
                mode <= 1;
            end
        end
        
        //circle waveform mode
        if (LSTATE == 1 && ~btnR && mode == 6) begin //button press left
            option <= (option >= 4 ? option : option + 1);
            display1Hz = 0;
        end
        
        if (RSTATE == 1 && ~btnL && mode == 6) begin //button press right
            option <= (option == 1 ? option : option - 1);
            display1Hz = 0;
        end
        
        if (mode == 6) begin //set logic when btnC is pressed
            waveMode <= 3;
            circleState <= option;
            waveformState <= waveformPrev;
            clrState <= clrPrev;
            histState <= histPrev;
            
            if (CSTATE == 1) begin
                waveMode <= 3;
                waveModePrev <= 3;
                circleState <= option;
                circlePrev <= option;
                option <= 1;
                mode <= 1;
            end
        end
        
        
        if (mode == 2) begin
        case (displayState)
            1: begin
                word0 <= (display1Hz >= 60 ? (FREQ0 == 0 ? 15 : FREQ0) : 15);
                word1 <= (display1Hz >= 60 ? FREQ1 : 27);
                word2 <= (display1Hz >= 60 ? FREQ2 : 14);
                word3 <= (display1Hz >= 60 ? FREQ3 : 26);
            end
            
            2: begin
                word0 <= (display1Hz >= 60 ? SPERCENT0 : 31);
                word1 <= (display1Hz >= 60 ? SPERCENT1 : 24);
                word2 <= (display1Hz >= 60 ? SPERCENT2 : 21);
                word3 <= (display1Hz >= 60 ? 37 : 37);
            end
            
        endcase
        
        end
        
        //display on 7SEG
        case (mode) 
            //LOCK
            0: begin word0 = 21; word1 = 24; word2 = 12; word3 = 20; end
            
            //Display sound level
            1: begin word0 = 0; word1 = 0; word2 = SEG_VOL0; word3 = SEG_VOL1; end
            
            //Display parameters - Freq / Vol %
            2: begin word0 = (FREQ0 == 0 ? 15 : FREQ0); word1 = FREQ1; word2 = FREQ2; word3 = FREQ3; end
            
            //Change screen color scheme
            3: begin word0 = 12; word1 = 21; word2 = 27; word3 = option; end
            
            //Waveform display mode
            4: begin
                if (waveformState == 1) begin
                    word0 = 32; word1 = 10; word2 = 31; word3 = 14;
                end 
                
                if (waveformState == 2) begin
                    word0 = 32; word1 = 10; word2 = 31; word3 = 15;
                end 

                if (waveformState == 3) begin
                    word0 = 11; word1 = 10; word2 = 27; word3 = 32;
                end 

                if (waveformState == 4) begin
                    word0 = 11; word1 = 21; word2 = 20; word3 = 32;
                end  
            end
            
            //History display mode
            5: begin 
                if (histState == 1) begin
                    word0 = 17; word1 = 28; word2 = 29; word3 = 15;
                end 
                
                if (histState == 2) begin
                    word0 = 17; word1 = 28; word2 = 29; word3 = 31;
                end 
    
                if (histState == 3) begin
                    word0 = 23; word1 = 34; word2 = 10; word3 = 23;
                end
            end
            
            //Circle display mode
            6: begin
                if (circleState == 1) begin
                    word0 = 12; word1 = 18; word2 = 27; word3 = 12;
                end 
                
                if (circleState == 2) begin
                    word0 = 12; word1 = 18; word2 = 27; word3 = 15;
                end 

                if (circleState == 3) begin
                    word0 = 15; word1 = 27; word2 = 26; word3 = 12;
                end 

                if (circleState == 4) begin
                    word0 = 15; word1 = 27; word2 = 26; word3 = 15;
                end 
             end
                        
        endcase
    
    end
    
    assign WORD0 = word0;
    assign WORD1 = word1;
    assign WORD2 = word2;
    assign WORD3 = word3;
    
    assign LOCK = lock;
    
    assign MODE = mode;
    assign CLRSTATE = clrState;
    
    assign WAVEMODE = waveMode;
    
    assign WAVEFORMSTATE = waveformState;
    assign HISTSTATE = histState;
    assign CIRCLESTATE = circleState;
    
endmodule
