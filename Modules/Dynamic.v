`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.02.2024 22:02:43
// Design Name: 
// Module Name: Dynamic
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


module Dynamic(input A,B,C,
              output Y);
              
wire X, W, O, Z, g3, g4;
    
not #5(X, A);
not #5 (W, B);
or #7 G1(O,A,B);
or G2(Z, X, C);
and G3(g3, W, A);
and G4(g4, O, Z);
or G5(Y, g3, g4);

endmodule
