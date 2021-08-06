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
    input [31:0] D_instr,
    // wb output : pipeline regs input
    input W_RegWrite,
    input W_RegToWrite,
    input W_WriteData,
    input [31:0]CMPA,
    input [31:0]CMPB,
    output [31:0] next_pc, 
    // EX input:pipeline regs

    output [31:0] D_EXTData,
    output [31:0] D_Rs_Data,
    output [31:0] D_Rt_Data,
    output D_Jump,
    output D_Branch,
    output PCSrc,
    output [1:0] D_RegDst,
    output [4:0] D_rs,
    output [4:0] D_rt

    );


    wire [31:0] E_EXTData;
    wire [31:0] E_Rs_Data;
    wire [31:0] E_Rt_Data;

    wire BranchExt32;
    wire BranchImm26;
    wire BranchReg;

    wire [1:0] ExtSel;
    wire [15:0] imm16;
    wire [15:0] imm26;
    wire [31:0] EXTData;

    wire [1:0]CompareSign;

    Controller_realize _D_controller (
        .instr(D_instr),
        .BranchExt32(BranchExt32),
        .BranchImm26(BranchImm26),
        .BranchReg(BranchReg),
        .Jump(D_Jump),
        .Branch(D_Branch),
        .RegDst(D_RegDst),
        .BorJ(PCSrc)

    )
    INSTR_SPLITTER _D_spiltter (
        .Instr(D_instr),
        .rs(D_rs),
        .rt(D_rt),
        .op(op),
        .imm16(imm16),
        .imm26(imm26)
    )
    GRF _grf_d(
        .clk(clk), 
        .Reset(reset),
        .RegWrite(W_RegWrite),
        .PC(D_PC), 
        .Read1(D_rs),
        .Read2(D_rt),
        .WriteAddr(W_RegToWrite),
        .WriteData(W_WriteData),
        .OutData1(E_Rs_Data),
        .outData2(E_Rt_Data)
    )

    EXT _ext(
        .imm16(imm16),
        .ExtSel(ExtSel),
        .imm32(EXTData)
    )

    CMP _cmp (
        .left(CMPA),
        .right(CMPB),
        .cmp_result(CompareSign)
    )
    MUX_NPC _npc  (
        .D_PC(D_PC),
        .imm26(imm26),
        .Reg32(E_Rs_Data),
        .Ext32(E_EXTData),
        .BranchExt32(BranchExt32),
        .BranchImm26(BranchImm26),
        .BranchReg(BranchReg),
        .CompareSign(CompareSign),
        .next_PC(next_pc)
    )


endmodule

module D_REG(
    input [31:0]D_PC,
    input [31:0]D_instr,
    input [31:0]D_Rs_Data,
    input [31:0]D_Rt_Data,
    input [31:0]D_EXTData,
    input reset,
    input stall, 
    output reg [31:0] E_PC_reg = 0,
    output reg [31:0] E_instr_reg = 0,
    output reg [31:0] E_Rs_Data_reg = 0,
    output reg [31:0] E_Rt_Data_reg = 0,
    output reg [31:0] E_EXTData_reg = 0
)

    always @(posedge clk) begin
        if (reset || stall ) begin 
            E_PC_reg <= 0;
            E_instr_reg <= 0;
            E_Rs_Data_reg <= 0;
            E_Rt_Data_reg <= 0;
            E_EXTData_reg <= 0;
    end
        else begin
            E_PC_reg <= D_PC;
            E_instr_reg <= D_instr;
            E_Rs_Data_reg <= E_Rs_Data;
            E_Rt_Data_reg <= E_Rt_Data;
            E_EXTData_reg <= E_EXTData;
        end
    end
endmodule