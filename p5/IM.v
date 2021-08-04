`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:27:14 08/02/2021 
// Design Name: 
// Module Name:    im 
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
module IM(
input [31:0]PC,
output [31:0]inst
);
    reg [31:0] rom[0:1023];
	 initial begin
	     $readmemh("code.txt",rom);
	 end
	 assign inst=rom[PC[11:2]];
endmodule

