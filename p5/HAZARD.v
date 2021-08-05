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
input [4:0]E_RegisterRd,
input [4:0]M_RegToWrite,
input [4:0]W_RegToWrite

input [4:0]E_RegisterRd,
input [4:0]M_RegToWrite,
input [4:0]W_RegToWrite,

input E_RegWriteSign,
input M_RegWriteSign,
input W_RegwriteSign, 

input [4:0]D_RegisterRs,
input [4:0]D_RegisterRd,

input [4:0]E_RegisterRs,
input [4:0]E_RegisterRd,

input [2:0]RegSrcE,
input [2:0]RegSrcM,
input BranchD,
input JumpD,
input JumpE,
input [1:0]RegDstD,

//stall out
output stall,
//forward out
output reg[1:0] ForwardrsD,
output reg[1:0] ForwardrtD,
output reg[1:0] ForwardrsE,
output reg[1:0] ForwardrtE,
output reg ForwardrtM
);


// check hazard 
initial begin 
	Forwardrs = 0;
	ForwardrtD  = 0;
	ForwardrsE  = 0;
	ForwardrtE  = 0;
	ForwardrtM = 0;
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
assign load_stall = 


endmodule