`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:35:14 08/04/2021 
// Design Name: 
// Module Name:    D 
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
// D 级：GRF，EXT，CMP，NPC
module D(
    input clk;
    input reset;
    input [31:0] D_PC, 
    input [31:0] D_instr;
    // wb阶段信号
    input W_RegWrite;
    input W_RegToWrite;
    input W_WriteData;
    // EX阶段信号
    output E_RsData,
    output E_RtData, 
    output [31:0] next_pc, 

    output reg [31:0] E_PC_reg = 0,
    output reg [31:0] E_instr_reg = 0,
    output reg [31:0] E_RS_Data_reg = 0,
    output reg [31:0] E_RT_Data_reg = 0,
    output reg [31:0] E_EXTData_reg = 0,
    );


    wire [31:0] E_EXTData;
    wire [31:0] E_RS_Data;
    wire [31:0] E_RT_Data;

    wire BranchExt32;
    wire BranchImm26;
    wire BranchReg;

    wire [1:0] ExtSel;
    wire [5:0] rs, rt;
    wire [15:0] imm16;
    wire [15:0] imm26;
    wire [31:0] EXTData;

    wire CompareSign;

    INSTR_SPLITTER _spiltter (
        .Instr(D_instr),
        .rs(rs),
        .rt(rt).
        .imm16(imm16),
        .imm26(imm26)
    )
    GRF _grf_d(
        .clk(clk), 
        .Reset(reset),
        .RegWrite(W_RegWrite),
        .PC(D_PC), 
        .Read1(rs),
        .Read2(rt),
        .WriteAddr(W_RegToWrite),
        .WriteData(W_WriteData),
        .OutData1(E_RsData),
        .outData2(E_RtData)
    )

    EXT _ext(
        .imm16(imm16),
        .ExtSel(ExtSel),
        .imm32(EXTData)
    )

    CMP _cmp (
        .left(),
        .right(),
        .cmp_result(CompareSign)
    )
    MUX_NPC _npc  (
        .PC(D_PC),
        .imm26(imm26),
        .Reg32(E_RsData),
        .Ext32(EXTData),
        .BranchExt32(BranchExt32),
        .BranchImm26(BranchImm26),
        .BranchReg(BranchReg),
        .CompareSign(CompareSign),
        .next_PC(next_pc)
    )

    
    // pipeline register of ID/EX


    always @(posedge clk) begin
        E_PC_reg <= D_PC;
        E_instr_reg <= D_instr;
        E_RS_Data_reg <= E_RS_Data;
        E_RT_Data_reg <= E_RT_Data;
        E_EXTData_reg <= E_EXTData;
    end

endmodule
