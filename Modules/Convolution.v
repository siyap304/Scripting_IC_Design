`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.01.2025 15:22:59
// Design Name: 
// Module Name: Conv_10_3
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


module Convolution(inp_matrix,out_matrix,inp_kernel);
parameter b=8;
parameter a=5; // matrix size
parameter c=3; //kernel size

input [a*a*b-1:0]inp_matrix;
input [c*c*b-1:0]inp_kernel;
output reg [(a-c+1)*b*(a-c+1)-1:0]out_matrix;

reg [b-1:0]matrix[a-1:0][a-1:0];//10*10
reg [b-1:0]kernel[c-1:0][c-1:0];//kernel
reg [2*b+c:0]out[a-c:0][a-c:0];

reg [2*b+c:0]sum;

integer row,col,i,j;

always @(*)
begin
    for(row=0; row<a; row=row+1)
    begin
        for(col=0; col<a; col=col+1)
        begin
            matrix[row][col] = inp_matrix[(row*a+col)*b+:b];
        end
    end
        
    for(row=0; row<c; row=row+1)
    begin
        for(col=0; col<c; col=col+1)
        begin
            kernel[row][col] = inp_kernel[(row*c+col)*b+:b];
        end
    end
    
    for(row=0; row<a-c+1; row=row+1)
    begin
        for(col=0; col<a-c+1; col=col+1)
        begin
            sum = 0;
            for(i=0; i<c; i=i+1)
            begin
                for(j=0; j<c; j=j+1)
                begin
                    sum = sum + (matrix[row+i][col+j]*kernel[i][j]);
                end
            end
            out[row][col] = sum;
        end
    end
        
    for(row=0; row<a-c+1; row=row+1)
    begin
        for(col=0; col<a-c+1; col=col+1)
        begin
            out_matrix[(row*(a-c+1)+col)*b+:b] = out[row][col];
        end       
    end
    
end
endmodule