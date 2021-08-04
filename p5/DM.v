`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:43:39 08/01/2021 
// Design Name: 
// Module Name:    DM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DM(
    input clk,
    input [31:0] PC,
    input Reset,
    input MemWrite,
    input MemRead,
    input [31:0]Address,
    input [31:0] Data,
    output [31:0] DataRead
    );
    reg[31:0] ram[0:1023];
    integer  i;
    initial begin
         for(i = 0; i < 1024; i = i + 1) ram[i] = 0;
    end

    always @(posedge clk) begin
        if (Reset) begin
            for(i = 0;i < 1024; i = i + 1) ram[i] <= 0;
        end
        else if(MemWrite) begin
            ram[Address[11:2]] <= Data;
            $display("@%h: *%h <= %h", PC, Address, Data);
        end
        
    end

    assign DataRead = ram[Address[11:2]];


endmodule
