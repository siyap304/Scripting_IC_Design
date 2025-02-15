`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.01.2025 14:50:28
// Design Name: 
// Module Name: Comparator
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


module Comparator(A, B, greater,lesser,equal);
input [7:0]A,B;
output reg greater,lesser,equal;

always@(*)
begin

greater = 1'b0;
lesser = 1'b0;
equal = 1'b0;

    if(A>B) 
        greater = 1'b1;
    else    
        if (A<B) 
            lesser = 1'b1;
        else 
            equal = 1'b1;

end
endmodule
