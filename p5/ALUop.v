`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:06:54 08/02/2021 
// Design Name: 
// Module Name:    ALUop 
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
`define R_alu 3'b010

`define addu 6'b100001
`define addu_alu 4'b0010
`define subu 6'b100011
`define subu_alu 4'b0110
`define jr 6'b001000


`define or_ 3'b011
`define or_alu 4'b0001
`define zero_alu 4'b0000
module ALUop(
    input [2:0] aluop,
    input [5:0] func,
    output reg[3:0] aluCtrl
    );
    always@(*)begin
		case (aluop)
			`R_alu: begin
				case(func)
					`addu: aluCtrl<=`addu_alu;
					`subu: aluCtrl<=`subu_alu;
					`jr: aluCtrl<=`addu_alu;
					default :  aluCtrl<=`zero_alu;
				endcase
			end
			`or_: aluCtrl<=`or_alu;
			3'b000: aluCtrl<=`addu_alu; // USE FOR LW SW to calculate addr
			3'b001: aluCtrl<=`subu_alu;
			3'b111: aluCtrl<=`zero_alu;
			default: aluCtrl<=`zero_alu;
		endcase
	end

endmodule
