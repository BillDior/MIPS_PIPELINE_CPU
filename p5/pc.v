`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:50:08 08/02/2021 
// Design Name: 
// Module Name:    pc 
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
module pc(
    input clk,
    input Reset,
	 input Enable, 
    input [31:0] next_pc,
    output [31:0] out_pc
    );
	reg [31:0] out = 32'h00003000;
	always @(posedge clk) begin
		if (Reset) begin
			out <= 32'h00003000;
		end
		else begin 
			if (Enable) begin
				out <= next_pc;
			end
		end
	end
	assign out_pc = out;
	

endmodule
