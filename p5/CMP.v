`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:13:42 08/05/2021 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
    input [31:0] left,
    input [31:0] right,
	 output reg [1:0]cmp_result
    );
	 always @(*) begin 
        if (left == right) cmp_result = 2'b01;
		  if (left ==  0) cmp_result = 2'b10;
		  if (left >= 0) cmp_result = 2'b1;
		  else  cmp_result = 2'b11;
	 end

endmodule
