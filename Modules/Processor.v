`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2024 16:06:13
// Design Name: 
// Module Name: Processor
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


module Processor(main_clk,out,ext);

input main_clk;
output reg [7:0] out;
reg [7:0] acc; 
output reg [7:0] ext;
reg CB;
//output slow_clk;

//clock_divider inst(main_clk, slow_clk);

reg [7:0] Register_file [15:0];
reg [7:0] ins_memory [15:0];
reg [3:0] PC;
reg hlt;
reg [7:0] div,quo;

initial
begin
Register_file[4'b0000] = 224;
Register_file[4'b0001] = 240;
Register_file[4'b0010] = 154;
Register_file[4'b0011] = 45;
Register_file[4'b0100] = 42;
Register_file[4'b0101] = 12;
Register_file[4'b0110] = 15;
Register_file[4'b0111] = 197;
Register_file[4'b1000] = 123;
Register_file[4'b1001] = 244;
Register_file[4'b1010] = 147;
Register_file[4'b1011] = 42;
Register_file[4'b1100] = 3;
Register_file[4'b1101] = 147;
Register_file[4'b1110] = 256;
Register_file[4'b1111] = 255;

//ins_memory[4'b0000] = 8'b00000000;
//ins_memory[4'b0001] = 8'b00000000;
//ins_memory[4'b0010] = 8'b00111100;
//ins_memory[4'b0011] = 8'b10001101;
//ins_memory[4'b0100] = 8'b10110001;
//ins_memory[4'b0101] = 8'b10010001;
//ins_memory[4'b0110] = 8'b01100001;
//ins_memory[4'b0111] = 8'b00010101;
//ins_memory[4'b1000] = 8'b00010110;
//ins_memory[4'b1001] = 8'b10101111;
//ins_memory[4'b1010] = 8'b10000001;
//ins_memory[4'b1011] = 8'b00000100;
//ins_memory[4'b1100] = 8'b11111111;
//ins_memory[4'b1101] = 8'b00000000;
//ins_memory[4'b1110] = 8'b01000111;
//ins_memory[4'b1111] = 8'b10111101;

ins_memory[4'b0101] = 8'b00000000;
ins_memory[4'b0110] = 8'b01000000;
ins_memory[4'b0111] = 8'b11111111;
ins_memory[4'b1000] = 8'b00010110;
ins_memory[4'b1001] = 8'b10101111;
ins_memory[4'b1010] = 8'b11111111;

//acc = 8'b10101010;
acc = 15;
ext = 0;
CB = 0;
hlt = 0;

PC = 4'b0101;
div = 8'b00000000;
quo = 8'b00000000;
end

integer y,i;
reg [1:0]flag;
initial flag = 0; 

always @(posedge main_clk && (hlt == 0)) begin

    if (ins_memory[PC][7:4] == 4'b0000)begin
        if (ins_memory[PC][3:0] == 4'b0001)
            acc = acc << 1;
        else if (ins_memory[PC][3:0] == 4'b0010)
            acc = acc >> 1;
        else if (ins_memory[PC][3:0] == 4'b0011)
            acc = {acc[0],acc[7:1]};
        else if (ins_memory[PC][3:0] == 4'b0100)
            acc = {acc[6:0],acc[7]};
        else if (ins_memory[PC][3:0] == 4'b0101)begin
                if (acc[7] == 0)
                    acc = acc >> 1;
                else 
                    acc = {1'b1, acc[7:1]};
            end
        else if (ins_memory[PC][3:0] == 4'b0110)
            {CB, acc} = acc + 1;
        else if (ins_memory[PC][3:0] == 4'b0111)
            {CB, acc} = acc - 1;
    end
    
    else if (ins_memory[PC][7:4] == 4'b0001)
            {CB, acc} = acc + Register_file[ins_memory[PC][3:0]];
    else if (ins_memory[PC][7:4] == 4'b0010)
            {CB, acc} = Register_file[ins_memory[PC][3:0]] - acc;
    else if (ins_memory[PC][7:4] == 4'b0011)
            {ext, acc} = acc * Register_file[ins_memory[PC][3:0]];
    else if (ins_memory[PC][7:4] == 4'b0100)begin
//                div = Register_file[ins_memory[PC][3:0]];
//                while(div >= acc)begin
//                    div = div - acc;
//                    quo = quo + 1;
//                end
//                acc = quo;
//                ext = div;
            y = 7;
            for (i = 0; i < 9; i = i +1)begin                
                if (div >= acc)begin
                    quo = quo << 1;
                    quo[0] = 1'b1;
                    div = div - acc;
                    flag = 1;
                end
                else begin
                    div = div << 1;
                    div[0] = Register_file[ins_memory[PC][3:0]][y];
                    y = y - 1'b1;
                    if (flag == 0)
                    quo = quo << 1;
                    else 
                    flag = 0; 
                end    
            end
            quo = quo << 1;
            if (div >= acc)begin
                    quo[0] = 1'b1;
                    div = div - acc;
             end
            acc = quo;
            ext = div;
            quo = 0; div = 0; y = 0;
//            acc = Register_file[ins_memory[PC][3:0]]/acc;
//            ext = Register_file[ins_memory[PC][3:0]]%acc;
         end
    else if (ins_memory[PC][7:4] == 4'b0101)
            acc = acc & Register_file[ins_memory[PC][3:0]];
    else if (ins_memory[PC][7:4] == 4'b0110)
            acc = acc ^ Register_file[ins_memory[PC][3:0]];
    else if (ins_memory[PC][7:4] == 4'b0111)
            CB = (acc < Register_file[ins_memory[PC][3:0]]);
    else if (ins_memory[PC][7:4] == 4'b1001)
            acc = Register_file[ins_memory[PC][3:0]];
    else if (ins_memory[PC][7:4] == 4'b1010)
            Register_file[ins_memory[PC][3:0]] = acc;
    else if (ins_memory[PC] == 8'b11111111)
            hlt = 1;
    else if (ins_memory[PC][7:4] == 4'b1000)begin
            ins_memory[ins_memory[PC][3:0]] = PC;
            PC = ins_memory[PC][3:0]; 
         end
    else if (ins_memory[PC][7:4] == 4'b1011)
            PC = ins_memory[ins_memory[PC][3:0]];
            
    PC = PC + 1'b1;
    out = acc;
end
endmodule
