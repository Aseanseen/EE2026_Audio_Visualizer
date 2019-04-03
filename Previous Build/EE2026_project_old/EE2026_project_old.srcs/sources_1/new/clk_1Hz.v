`timescale 1ns / 1ps
//my slow clocky module

module clk_1Hz(input CLOCK, output clk_1Hz);
   //wire clk_1Hz = 0;
    reg clkstate = 0;
    reg [29:0] COUNTER = 1;
    
    
    always @ (posedge CLOCK) begin
        COUNTER <= (COUNTER >= 30'b011111110010100000010101011000 ? 0 : COUNTER + 16);
        clkstate <= (COUNTER == 0 ? ~clkstate : clkstate);
    
    end
    
    assign clk_1Hz = clkstate;

endmodule
