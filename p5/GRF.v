`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:31:24 08/01/2021 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
    input clk,
    input RegWrite,
    input Reset,
    input [4:0] Read1,
    input [4:0] Read2,
    input [4:0] WriteAddr,
    input [31:0] WriteData,
    input [31:0] PC,
	 output [31:0] OutData1,
	 output [31:0] OutData2
    );
	 
    reg[31:0] regs[0:31];
    integer i;
    initial begin
    for (i = 0; i < 32;i = i + 1) regs[i] <= 0;
    end
    
    always @(posedge clk) begin
        if (Reset) begin 
            for (i =  0;i < 32; i=i+1) regs[i] <= 0; //do reset
        end
        else begin 
            if (RegWrite && WriteAddr > 0) begin  // do not modifiy the 0 register
                regs[WriteAddr] <= WriteData;
                $display("@%h: $%d <= %h", PC, WriteAddr,WriteData);
            end
        end

    end
	 
    assign OutData1 = regs[Read1];
    assign OutData2 = regs[Read2];


endmodule