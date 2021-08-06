`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:40:22 08/05/2021 
// Design Name: 
// Module Name:    HAZARD 
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
module HAZARD(
//stall
input [4:0]E_RegisterRt,
input [4:0]M_RegToWrite,
input [4:0]W_RegToWrite

input [4:0]E_RegisterRt,
input [4:0]M_RegToWrite,
input [4:0]W_RegToWrite,

input E_RegWriteSign,
input M_RegWriteSign,
input W_RegwriteSign, 

input [4:0]D_RegisterRs,
input [4:0]D_RegisterRt,

input [4:0]E_RegisterRs,
input [4:0]E_RegisterRt,

input [2:0]E_RegDst,
input [2:0]M_RegDst,

input E_Load, 
input M_Load, 
input D_Branch,
input D_Jump,
input E_Jump,
input [1:0]D_RegDst,

//stall out
output stall,
//forward out
output reg[1:0] D_Rs_Forward,
output reg[1:0] D_Rt_Forward,
output reg[1:0] E_Rs_Forward,
output reg[1:0] E_Rt_Forward,
output reg M_rt_Forward
);


// check hazard 
initial begin 
	D_Rs_Forward = 0;
	D_Rt_Forward  = 0;
	E_Rs_Forward  = 0;
	E_Rt_Forward  = 0;
	M_rt_Forward = 0;
end
always @(*) begin
	if (E_RegWToWrite != 0 && E_RegWriteSign && E_RegWToWrite == D_RegisterRs)  D_Rs_Forward = 3;
	else if (M_RegWToWrite != 0 && M_RegWriteSign && M_RegWToWrite == D_RegisterRs)  D_Rs_Forward = 2;
	else if (W_RegWToWrite != 0 && W_RegWriteSign && W_RegWToWrite == D_RegisterRs)  D_Rs_Forward = 1;
	else  D_Rs_Forward = 0;


	if (E_RegWToWrite != 0 && E_RegWriteSign && E_RegWToWrite == D_RegisterRt)  D_Rt_Forward = 3;
	else if (M_RegWToWrite != 0 && M_RegWriteSign && M_RegWToWrite == D_RegisterRt)  D_Rt_Forward = 2;
	else if (W_RegWToWrite != 0 && W_RegWriteSign && W_RegWToWrite == D_RegisterRt)  D_Rt_Forward = 1;
	else  D_Rt_Forward = 0;

	if (M_RegWToWrite != 0 && M_RegWriteSign && M_RegWToWrite == E_RegisterRs)  E_Rs_Forward = 2;
	else if (W_RegWToWrite != 0 && W_RegWriteSign && W_RegWToWrite == E_RegisterRs)  E_Rs_Forward = 1;
	else  E_Rs_Forward = 0;


	if (M_RegWToWrite != 0 && M_RegWriteSign && M_RegWToWrite == E_RegisterRt)  E_Rt_Forward = 2;
	else if (W_RegWToWrite != 0 && W_RegWriteSign && W_RegWToWrite == E_RegisterRt)  E_Rt_Forward = 1;
	else  E_Rt_Forward = 0;


	 M_rt_Forward = (W_RegWToWrite != 0 && W_RegWriteSign && W_RegWToWrite == M_RegisterRt);

end



// check stall 
wire load_stall;
wire branch_stall;
wire jump_stall;

assign branch_stall = D_Branch &&
                     ((E_RegWToWrite != 0 && E_RegWriteSign && E_RegDst != 2'b10 && (D_RegisterRs == E_RegWToWrite || D_RegisterRt == E_RegWToWrite))  ||
                     (M_RegToWrite != 0 && M_Load && (D_RegisterRs == M_RegWToWrite || D_RegisterRt == M_RegWToWrite))
                        );

assign jump_stall =  D_jump &&
                     ((E_RegWToWrite != 0 && E_RegWriteSign && E_RegDst != 2'b10 && D_RegisterRs == E_RegWToWrite)  ||
                     (M_RegToWrite != 0 && M_Load && (D_RegisterRs == M_RegWToWrite || D_RegisterRt == M_RegWToWrite))
                        );

assign load_stall = E_Load && E_RegWToWrite != 0 && ((D_RegDst != 0 && D_RegisterRt == E_RegWToWrite) || D_RegisterRt == E_RegWToWrite);

endmodule