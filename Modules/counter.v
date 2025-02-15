`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2025 15:15:03
// Design Name: 
// Module Name: counter
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


module counter(clk, reset, Q);

input clk, reset;
output reg [3:0]Q;

reg [3:0]count;
//wire slow_clk;

//clock_divider(main_clk, slow_clk);

always@(posedge clk)
begin

if(!reset) count = 0;
else
    begin
        count = count + 1;
    end 
Q = count;
end
endmodule
