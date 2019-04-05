`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------------------------------  
//                  DRAWING GRID LINES AND TICKS ON SCREEN
// Description:
// Grid lines are drawn at pixel # 320 along the x-axis, and
// pixel #768 along the y-axis

// Note the VGA controller is configured to produce a 1024 x 1280 pixel resolution
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
// TOOD:    Draw grid lines at every 80-th pixel along the horizontal axis, and every 64th pixel
//          along the vertical axis. This gives us a 16x16 grid on screen. 
//          
//          Further draw ticks on the central x and y grid lines spaced 16 and 8 pixels apart in the 
//          horizontal and vertical directions respectively. This gives us 5 sub-divisions per division 
//          in the horizontal and 8 sub-divisions per divsion in the vertical direction   
//-------------------------------------------------------------------------  
  
//////////////////////////////////////////////////////////////////////////////////


module Draw_Background(
    input clk,
    input [11:0] VGA_HORZ_COORD,
    input [11:0] VGA_VERT_COORD,
    
    input [11:0] mouseXPos,
    input [11:0] mouseYPos,
    input mouseLeft,
    input [2:0] clrstate,
    input [5:0] waveMode,
    input [5:0] i,
    
    input [11:0] background,
    input [11:0] axes,
    input [11:0] grid,
    input [11:0] ticks,
    
    output [3:0] VGA_Red_Grid,
    output [3:0] VGA_Green_Grid,
    output [3:0] VGA_Blue_Grid
    );
    
// The code below draws two grid lines. Modify the codes to draw more grid lines. 
    wire Condition_For_Axes = (VGA_HORZ_COORD == 640) ||  (VGA_VERT_COORD == 512) ;


// Using the gridline example, insert your code below to draw ticks on the x-axis and y-axis.
    wire Condition_For_Ticks = ((VGA_HORZ_COORD % 80 == 0) && (VGA_VERT_COORD > 502 && VGA_VERT_COORD < 522)) || (VGA_VERT_COORD % 64 == 0) && (VGA_HORZ_COORD > 630 && VGA_HORZ_COORD < 650);
    wire Condition_For_SmallT = ((VGA_HORZ_COORD % 20 == 0) && (VGA_VERT_COORD > 507 && VGA_VERT_COORD < 517)) || (VGA_VERT_COORD % 16 == 0) && (VGA_HORZ_COORD > 635 && VGA_HORZ_COORD < 645);
    wire Condition_For_Grid = ((VGA_HORZ_COORD % 80 == 0) && (VGA_VERT_COORD % 5 == 0) || ((VGA_VERT_COORD % 64 == 0) && (VGA_HORZ_COORD % 5 == 0)));
    wire Condition_For_Mouse =  (mouseXPos < 10 && VGA_HORZ_COORD < mouseXPos + 10 && VGA_VERT_COORD < mouseYPos + 2 && VGA_VERT_COORD > mouseYPos - 2)
    || (mouseXPos == 0 && VGA_HORZ_COORD < 2 && VGA_VERT_COORD < mouseYPos + 10 && VGA_VERT_COORD > mouseYPos - 10) 
    || (mouseYPos == 0 && VGA_VERT_COORD < 2 && VGA_HORZ_COORD < mouseXPos + 10 && VGA_HORZ_COORD > mouseXPos - 10) 
    || (mouseYPos < 10 && VGA_VERT_COORD < mouseYPos + 10 && VGA_HORZ_COORD < mouseXPos + 2 && VGA_HORZ_COORD > mouseXPos - 2)
    || ( VGA_HORZ_COORD < mouseXPos + 10 && VGA_HORZ_COORD > mouseXPos - 10 && VGA_VERT_COORD < mouseYPos + 2 && VGA_VERT_COORD > mouseYPos - 2) 
    || ( VGA_VERT_COORD < mouseYPos + 10 && VGA_VERT_COORD > mouseYPos - 10 && VGA_HORZ_COORD < mouseXPos + 2 && VGA_HORZ_COORD > mouseXPos - 2);
    
    wire a1, a2, a3, a4, a5 ,a6, a7, a8, a9, a10, a11, a12 , a13, a14, a15;
    wire b1, b2, b3, b4;
    wire c1, c2, c3, c4;
    wire d1, d2, d3, d4;
    wire e1, e2, e3, e4;
    wire f1, f2, f3, f4;
    wire g1, g2, g3, g4;
    
    char ahar1(clk, 69, 20, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a1);
    char ahar2(clk, 69, 29, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a2);
    char ahar3(clk, 50, 38, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a3);
    char ahar4(clk, 48, 47, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a4);
    char ahar5(clk, 50, 56, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a5);
    char ahar6(clk, 54, 65, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a6);
    char ahar7(clk, 66, 83, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a7);
    char ahar8(clk, 89, 92, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a8);
    char ahar9(clk, 74, 110, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a9);
    char ahar10(clk, 89, 119, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a10);
    char ahar11(clk, 38, 137, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a11);
    char ahar12(clk, 68, 155, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a12);
    char ahar13(clk, 65, 164, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a13);
    char ahar14(clk, 78, 173, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a14);
    char ahar15(clk, 1, 191, 20, VGA_HORZ_COORD, VGA_VERT_COORD, a15);
    
    char bhar1(clk, 67, 1226, 848, VGA_HORZ_COORD, VGA_VERT_COORD, b1);
    char bhar2(clk, 111, 1235, 848, VGA_HORZ_COORD, VGA_VERT_COORD, b2);
    char bhar3(clk, 108, 1244, 848, VGA_HORZ_COORD, VGA_VERT_COORD, b3);
    char bhar4(clk, 115, 1253, 848, VGA_HORZ_COORD, VGA_VERT_COORD, b4);
    
    char char1(clk, 83, 1232, 873, VGA_HORZ_COORD, VGA_VERT_COORD, c1);
    char char2(clk, 49, 1245, 873, VGA_HORZ_COORD, VGA_VERT_COORD, c2);
    
    char dhar1(clk, 83, 1232, 903, VGA_HORZ_COORD, VGA_VERT_COORD, d1);
    char dhar2(clk, 50, 1245, 903, VGA_HORZ_COORD, VGA_VERT_COORD, d2);
        
    char ehar1(clk, 83, 1232, 933, VGA_HORZ_COORD, VGA_VERT_COORD, e1);
    char ehar2(clk, 51, 1245, 933, VGA_HORZ_COORD, VGA_VERT_COORD, e2);
            
    char fhar1(clk, 83, 1232, 963, VGA_HORZ_COORD, VGA_VERT_COORD, f1);
    char fhar2(clk, 52, 1245, 963, VGA_HORZ_COORD, VGA_VERT_COORD, f2);
                
    char ghar1(clk, 83, 1232, 993, VGA_HORZ_COORD, VGA_VERT_COORD, g1);
    char ghar2(clk, 53, 1245, 993, VGA_HORZ_COORD, VGA_VERT_COORD, g2);
    
    wire blk1, blk2, blk3;
    char block1(clk, 66, 20, 993, VGA_HORZ_COORD, VGA_VERT_COORD, blk1);
    char block2(clk, 108, 28, 993, VGA_HORZ_COORD, VGA_VERT_COORD, blk2);
    char block3(clk, 107, 36, 993, VGA_HORZ_COORD, VGA_VERT_COORD, blk3);
    
    wire ba1, ba2, ba3;
    char bar1(clk, 66, 20, 963, VGA_HORZ_COORD, VGA_VERT_COORD, ba1);
    char bar2(clk, 97, 28, 963, VGA_HORZ_COORD, VGA_VERT_COORD, ba2);
    char bar3(clk, 114, 36, 963, VGA_HORZ_COORD, VGA_VERT_COORD, ba3);
    
    wire fi1, fi2, fi3, fi4;
    char fill1(clk, 70, 20, 933, VGA_HORZ_COORD, VGA_VERT_COORD, fi1);
    char fill2(clk, 105, 28, 933, VGA_HORZ_COORD, VGA_VERT_COORD, fi2);
    char fill3(clk, 108, 36, 933, VGA_HORZ_COORD, VGA_VERT_COORD, fi3);
    char fill4(clk, 108, 44, 933, VGA_HORZ_COORD, VGA_VERT_COORD, fi4);
    
    wire n1, n2, n3, n4;
    char normal1(clk, 78, 20, 903, VGA_HORZ_COORD, VGA_VERT_COORD, n1);
    char normal2(clk, 111, 28, 903, VGA_HORZ_COORD, VGA_VERT_COORD, n2);
    char normal3(clk, 114, 36, 903, VGA_HORZ_COORD, VGA_VERT_COORD, n3);
    char normal4(clk, 109, 44, 903, VGA_HORZ_COORD, VGA_VERT_COORD, n4);
    
    wire wf1, wf2, wf3, wf4, wf5;
    char waveform1(clk, 87, 15, 878, VGA_HORZ_COORD, VGA_VERT_COORD, wf1);
    char waveform2(clk, 97, 23, 878, VGA_HORZ_COORD, VGA_VERT_COORD, wf2);
    char waveform3(clk, 118, 31, 878, VGA_HORZ_COORD, VGA_VERT_COORD, wf3);
    char waveform4(clk, 101, 39, 878, VGA_HORZ_COORD, VGA_VERT_COORD, wf4);
    char waveform5(clk, 115, 47, 878, VGA_HORZ_COORD, VGA_VERT_COORD, wf5);
    
    wire h1, h2, h3, h4;
    char hist1(clk, 72, 80, 878, VGA_HORZ_COORD, VGA_VERT_COORD, h1);
    char hist2(clk, 105, 89, 878, VGA_HORZ_COORD, VGA_VERT_COORD, h2);
    char hist3(clk, 115, 98, 878, VGA_HORZ_COORD, VGA_VERT_COORD, h3);
    char hist4(clk, 116, 107, 878, VGA_HORZ_COORD, VGA_VERT_COORD, h4);
    
    wire v1, v2, v3;
    char vol1(clk, 86, 85, 903, VGA_HORZ_COORD, VGA_VERT_COORD, v1);
    char vol2(clk, 111, 94, 903, VGA_HORZ_COORD, VGA_VERT_COORD, v2);
    char vol3(clk, 108, 103, 903, VGA_HORZ_COORD, VGA_VERT_COORD, v3);
    
    wire fr1, fr2, fr3, fr4;
    char freq1(clk, 70, 85, 933, VGA_HORZ_COORD, VGA_VERT_COORD, fr1);
    char freq2(clk, 114, 94, 933, VGA_HORZ_COORD, VGA_VERT_COORD, fr2);
    char freq3(clk, 101, 103, 933, VGA_HORZ_COORD, VGA_VERT_COORD, fr3);
    char freq4(clk, 113, 112, 933, VGA_HORZ_COORD, VGA_VERT_COORD, fr4);
    
    wire m1, m2, m3, m4;
    char meow1(clk, 77, 85, 963, VGA_HORZ_COORD, VGA_VERT_COORD, m1);
    char meow2(clk, 101, 94, 963, VGA_HORZ_COORD, VGA_VERT_COORD, m2);
    char meow3(clk, 111, 103, 963, VGA_HORZ_COORD, VGA_VERT_COORD, m3);
    char meow4(clk, 119, 112, 963, VGA_HORZ_COORD, VGA_VERT_COORD, m4);
    
    wire ci1, ci2, ci3, ci4;
    char circ1(clk, 67, 145, 878, VGA_HORZ_COORD, VGA_VERT_COORD, ci1);
    char circ2(clk, 105, 154, 878, VGA_HORZ_COORD, VGA_VERT_COORD, ci2);
    char circ3(clk, 114, 163, 878, VGA_HORZ_COORD, VGA_VERT_COORD, ci3);
    char circ4(clk, 99, 172, 878, VGA_HORZ_COORD, VGA_VERT_COORD, ci4);
    
    wire nc1, nc2, nc3, nc4;
    char normalc1(clk, 78, 150, 903, VGA_HORZ_COORD, VGA_VERT_COORD, nc1);
    char normalc2(clk, 111, 159, 903, VGA_HORZ_COORD, VGA_VERT_COORD, nc2);
    char normalc3(clk, 114, 168, 903, VGA_HORZ_COORD, VGA_VERT_COORD, nc3);
    char normalc4(clk, 109, 177, 903, VGA_HORZ_COORD, VGA_VERT_COORD, nc4);
    
    wire s1, s2, s3, s4;
    char slow1(clk, 83, 150, 933, VGA_HORZ_COORD, VGA_VERT_COORD, s1);
    char slow2(clk, 108, 159, 933, VGA_HORZ_COORD, VGA_VERT_COORD, s2);
    char slow3(clk, 111, 168, 933, VGA_HORZ_COORD, VGA_VERT_COORD, s3);
    char slow4(clk, 119, 177, 933, VGA_HORZ_COORD, VGA_VERT_COORD, s4);
    
    wire frc1, frc2, frc3, frc4;
    char freqc1(clk, 70, 150, 963, VGA_HORZ_COORD, VGA_VERT_COORD, frc1);
    char freqc2(clk, 114, 159, 963, VGA_HORZ_COORD, VGA_VERT_COORD, frc2);
    char freqc3(clk, 101, 168, 963, VGA_HORZ_COORD, VGA_VERT_COORD, frc3);
    char freqc4(clk, 113, 177, 963, VGA_HORZ_COORD, VGA_VERT_COORD, frc4);
    
    wire frcs1, frcs2, frcs3, frcs4;
    char freqcs1(clk, 70, 150, 993, VGA_HORZ_COORD, VGA_VERT_COORD, frcs1);
    char freqcs2(clk, 114, 159, 993, VGA_HORZ_COORD, VGA_VERT_COORD, frcs2);
    char freqcs3(clk, 83, 168, 993, VGA_HORZ_COORD, VGA_VERT_COORD, frcs3);
    char freqcs4(clk, 108, 177, 993, VGA_HORZ_COORD, VGA_VERT_COORD, frcs4);
    
    wire Condition_For_Text = c1 || c2
    || d1 || d2
    || e1 || e2
    || f1 || f2
    || g1 || g2
    || blk1 || blk2 || blk3
    || ba1 || ba2 || ba3
    || fi1 || fi2 || fi3 || fi4
    || n1 || n2 || n3 || n4
    || v1 || v2 || v3
    || fr1 || fr2 || fr3 || fr4
    || m1 || m2 || m3 || m4
    || nc1 || nc2 || nc3 || nc4
    || s1 || s2 || s3 || s4
    || frc1 || frc2 || frc3 || frc4
    || frcs1 || frcs2 || frcs3 || frcs4;
    wire Condition_For_Title = a1 || a2 || a3 || a4 || a5 || a6 || a7 || a8 || a9 || a10 || a11 || a12 || a13 || a14 || a15
    || b1 || b2 || b3 || b4
    || wf1 || wf2 || wf3 || wf4 || wf5
    || h1 || h2 || h3 || h4
    || ci1 || ci2 || ci3 || ci4;
    
    wire Condition_For_Box = ((VGA_HORZ_COORD >= 1220 && VGA_HORZ_COORD < 1265) && 
    ((VGA_VERT_COORD >= 868 && VGA_VERT_COORD < 894) ||
    (VGA_VERT_COORD >= 898 && VGA_VERT_COORD < 924) ||
    (VGA_VERT_COORD >= 928 && VGA_VERT_COORD < 954) ||
    (VGA_VERT_COORD >= 958 && VGA_VERT_COORD < 984) ||
    (VGA_VERT_COORD >= 988 && VGA_VERT_COORD < 1014))) ||
    
    ((VGA_HORZ_COORD >= 15 && VGA_HORZ_COORD < 60) &&
    ((VGA_VERT_COORD >= 898 && VGA_VERT_COORD < 924) ||
    (VGA_VERT_COORD >= 928 && VGA_VERT_COORD < 954) ||
    (VGA_VERT_COORD >= 958 && VGA_VERT_COORD < 984) ||
    (VGA_VERT_COORD >= 988 && VGA_VERT_COORD < 1014))) ||
    
    ((VGA_HORZ_COORD >= 80 && VGA_HORZ_COORD < 125) &&
    ((VGA_VERT_COORD >= 898 && VGA_VERT_COORD < 924) ||
    (VGA_VERT_COORD >= 928 && VGA_VERT_COORD < 954) ||
    (VGA_VERT_COORD >= 958 && VGA_VERT_COORD < 984))) ||
    
    ((VGA_HORZ_COORD >= 145 && VGA_HORZ_COORD < 190) &&
    ((VGA_VERT_COORD >= 898 && VGA_VERT_COORD < 924) ||
    (VGA_VERT_COORD >= 928 && VGA_VERT_COORD < 954) ||
    (VGA_VERT_COORD >= 958 && VGA_VERT_COORD < 984) ||
    (VGA_VERT_COORD >= 988 && VGA_VERT_COORD < 1014)))
    
    ? 1 : 0;
    
    //condition for circle indicator for circle waveform
    wire arc0 = ((VGA_HORZ_COORD + VGA_VERT_COORD) < 1149) && (VGA_HORZ_COORD > 639);
    wire arc1 = ((VGA_HORZ_COORD + VGA_VERT_COORD) > 1149) && (VGA_VERT_COORD < 511);
    wire arc2 = (VGA_HORZ_COORD < (128 + VGA_VERT_COORD)) && (VGA_HORZ_COORD > 639);
    wire arc3 = (VGA_HORZ_COORD > (128 + VGA_VERT_COORD)) && (VGA_VERT_COORD > 511);
    wire arc4 = ((VGA_HORZ_COORD + VGA_VERT_COORD) > 1149) && (VGA_HORZ_COORD < 639);
    wire arc5 = ((VGA_HORZ_COORD + VGA_VERT_COORD) < 1149) && (VGA_VERT_COORD > 511);
    wire arc6 = (VGA_HORZ_COORD < (128 + VGA_VERT_COORD)) && (VGA_VERT_COORD < 511);
    wire arc7 = (VGA_HORZ_COORD > (128 + VGA_VERT_COORD)) && (VGA_HORZ_COORD < 639);
    
    //conditions for lighting up a specific arc
    wire Condition_For_Arc0 = (arc0 && waveMode == 3 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) >= (22500) && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (25600));
    wire Condition_For_Arc1 = (arc1 && waveMode == 3 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) >= (22500) && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (25600));
    wire Condition_For_Arc2 = (arc2 && waveMode == 3 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) >= (22500) && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (25600));
    wire Condition_For_Arc3 = (arc3 && waveMode == 3 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) >= (22500) && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (25600));
    wire Condition_For_Arc4 = (arc4 && waveMode == 3 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) >= (22500) && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (25600));
    wire Condition_For_Arc5 = (arc5 && waveMode == 3 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) >= (22500) && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (25600));
    wire Condition_For_Arc6 = (arc6 && waveMode == 3 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) >= (22500) && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (25600));
    wire Condition_For_Arc7 = (arc7 && waveMode == 3 && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) >= (22500) && ((VGA_HORZ_COORD - 639) * (VGA_HORZ_COORD - 639) + (VGA_VERT_COORD - 511) * (VGA_VERT_COORD - 511)) <= (25600));
    
    wire Condition_For_HBox = (clrstate == 1 && VGA_HORZ_COORD >= 1220 && VGA_HORZ_COORD < 1265 && VGA_VERT_COORD >= 868 && VGA_VERT_COORD < 894)
    || (clrstate == 2 && VGA_HORZ_COORD >= 1220 && VGA_HORZ_COORD < 1265 && VGA_VERT_COORD >= 898 && VGA_VERT_COORD < 924)
    || (clrstate == 3 && VGA_HORZ_COORD >= 1220 && VGA_HORZ_COORD < 1265 && VGA_VERT_COORD >= 928 && VGA_VERT_COORD < 954)
    || (clrstate == 4 && VGA_HORZ_COORD >= 1220 && VGA_HORZ_COORD < 1265 && VGA_VERT_COORD >= 958 && VGA_VERT_COORD < 984)
    || (clrstate == 5 && VGA_HORZ_COORD >= 1220 && VGA_HORZ_COORD < 1265 && VGA_VERT_COORD >= 988 && VGA_VERT_COORD < 1014);
    
// Please modify below codes to change the background color and to display ticks defined above
    wire [3:0] bgR;
    wire [3:0] bgG;
    wire [3:0] bgB;
    
    wire [3:0] axeR;
    wire [3:0] axeG;
    wire [3:0] axeB;
    
    wire [3:0] gridR;
    wire [3:0] gridG;
    wire [3:0] gridB;
    
    wire [3:0] tickR;
    wire [3:0] tickG;
    wire [3:0] tickB;
    
    assign bgR = background >> 8;
    assign bgG = background << 4 >> 8;
    assign bgB = background << 8 >> 8;
    
    assign axeR = axes >> 8;
    assign axeG = axes << 4 >> 8;
    assign axeB = axes << 8 >> 4;
    
    assign gridR = grid >> 8;
    assign gridG = grid  << 4 >> 4;
    assign gridB = grid << 8 >> 8;
    
    assign tickR = ticks >> 8;
    assign tickG = ticks << 4 >> 8;
    assign tickB = ticks << 8 >> 8;
    
    assign VGA_Red_Grid = Condition_For_Title ? 4'b1111 : Condition_For_Mouse ? 4'b1111 : (Condition_For_HBox) ? 4'b0010 : (Condition_For_Box) ? 4'b0100 : (Condition_For_Axes) ? axeR : (Condition_For_Ticks || Condition_For_SmallT) ? tickR : Condition_For_Grid ? gridR : bgR;
    
    assign VGA_Green_Grid = Condition_For_Title ? 4'b1111 : Condition_For_Mouse ? (mouseLeft ? 4'b1000 : 4'b1111) : (Condition_For_Text) ? 4'b1111 : (Condition_For_HBox) ? 4'b0010 : 
    ((Condition_For_Arc0 && i == 0) || (Condition_For_Arc1 && i == 1) || (Condition_For_Arc2 && i == 2) || (Condition_For_Arc3 && i == 3) || (Condition_For_Arc4 && i == 4) || (Condition_For_Arc5 && i == 5) || (Condition_For_Arc6 && i == 6) || (Condition_For_Arc7 && i == 7)) ? gridB + 4 :  
    (Condition_For_Box) ? 4'b0100 : (Condition_For_Axes) ? axeG : (Condition_For_Ticks || Condition_For_SmallT) ? tickG : Condition_For_Grid ? gridG : bgG;
    
    assign VGA_Blue_Grid = Condition_For_Title ? 4'b1111 : Condition_For_Mouse ? mouseLeft ? 4'b1000 : 4'b1111 : (Condition_For_HBox) ? 4'b0010 : 
    ((Condition_For_Arc0) || (Condition_For_Arc1) || (Condition_For_Arc2) || (Condition_For_Arc3) || (Condition_For_Arc4) || (Condition_For_Arc5) || (Condition_For_Arc6) || (Condition_For_Arc7)) ? gridB + 4 : 
    (Condition_For_Box) ? 4'b0100 : (Condition_For_Axes) ? axeB : (Condition_For_Ticks || Condition_For_SmallT) ? tickB : Condition_For_Grid ? gridB : bgB;
    
endmodule
