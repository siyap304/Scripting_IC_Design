`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.01.2024 08:38:13
// Design Name: 
// Module Name: Full_Adder
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


module Full_Adder(A, B, C, S, Carry);
input A, B, C;
output S, Carry;

wire p, q, r;

xor(p, A, B);
and(q, p, C);
and(r, A, B);
or(Carry, q, r);
xor(S, p, C);

endmodule
