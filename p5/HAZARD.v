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
output [1:0]ForwardrsD,
output [1:0]ForwardrtD,
output [1:0]ForwardrsE,
output [1:0]ForwardrtE,
output ForwardrtM
);


// check hazard 

assign D_Rs_Forward = E
endmodule