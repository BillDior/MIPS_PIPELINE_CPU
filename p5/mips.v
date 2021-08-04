`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:05:33 08/02/2021 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
    wire [5:0] op;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] shamt;
    wire [15:0] imm16;
    wire [25:0] imm26;
    wire [5:0] func;
    wire [31:0] Instr;

    assign op = Instr[31:26];
    assign rs = Instr[25:21];
    assign rt = Instr[20:16];
    assign rd = Instr[15:11];
    assign shamt = Instr[10:6];
    assign func = Instr[5:0];
    assign imm16 = Instr[15:0];
    assign imm26 = Instr[25:0];

    wire [1:0] RegDst;
    wire ALUSrc;
    wire RegWrite;
    wire [4:0] RegToWrite;
    wire MemRead;
    wire MemWrite;
    wire [1:0] MemToReg;
    wire [1:0] ExtSel;
    wire BranchExt32;
    wire BranchImm26;
    wire BranchReg;
    wire EqualSign;

    wire [31:0] imm32;
    // wire [4:0] ReadAddr1; //from rs
    // wire [4:0] ReadAddr2; // from rt
    wire [31:0] ReadData1; //from rs
    wire [31:0] ReadData2; // from rt
    wire [31:0] WriteData;
    wire [31:0] EXTData;
    wire [2:0] ALUopInput;
    wire [3:0] aluCtrl;
    wire [4:0] WriteAddr;
    wire [31:0] MemData;
    wire [31:0] ALUInput1, ALUInput2;
    wire [31:0] ALUResult;
    wire [31:0] PC;
    wire [31:0] PC4;
    wire [31:0] next_pc;
    wire [31:0] DMData; // GRF's ReadData 2
    wire [31:0] DMDataRead;
    Controller_realize _controller(
        .op(op),
        .func(func),
        .ALUopInput(ALUopInput),
        .RegDst(RegDst), 
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite), 
        .MemToReg(MemToReg), 
        .ExtSel(ExtSel),
        .BranchReg(BranchReg),
        .BranchImm26(BranchImm26),
        .BranchExt32(BranchExt32)
    );

    pc _pc(
        .clk(clk),
        .Reset(reset),
        .next_pc(next_pc), 
        .out_pc(PC)
    );

    MUX_NPC _nextpc(
        .PC(PC), 
        .imm26(imm26), 
        .Reg32(ReadData1), 
        .Ext32(EXTData), 
        .BranchExt32(BranchExt32),
        .BranchImm26(BranchImm26),
        .BranchReg(BranchReg),
        .EuqalSign(EqualSign),
        .next_pc(next_pc),
        .pc_add_4(PC4)
    );

    IM _im (
        .PC(PC),
        .inst(Instr)
    );

    MUX_4 _mux_addr(
        .data0(rt),
        .data1(rd),
        .data2(5'b11111), // for jal
        .data3(5'b0),
        .selector(RegDst), 
        .out(RegToWrite) 
    );

    MUX_4_32 _grf_data_mux(
        .data0(ALUResult),  //default
        .data1(DMDataRead), 
        .data2(PC4),
        .data3(32'b0),
        .selector(MemToReg),
        .out(WriteData)
    );
    /*assign WriteData = MemToReg? DMDataRead :
                       SavePc4 ? PC4 :
                       ALUResult;*/

    GRF _grf(
        .clk(clk),
        .Reset(reset),
        .RegWrite(RegWrite),
        .PC(PC),
        .Read1(rs), 
        .Read2(rt),
        .WriteAddr(RegToWrite),
        .WriteData(WriteData),
        .OutData1(ReadData1),
        .OutData2(ReadData2)
    );
    assign ALUInput1 = ReadData1;
    assign ALUInput2 = ALUSrc? EXTData : ReadData2;

    ALUop _aluop (
        .aluop(ALUopInput),
        .func(func),
        .aluCtrl(aluCtrl)
    );

    ALU _alu (
        .reg1(ALUInput1),
        .reg2(ALUInput2), 
        .aluCtrl(aluCtrl), 
        .Result(ALUResult),
        .EqualSign(EqualSign)
    );


    DM _dm (
        .PC(PC),
        .clk(clk),
        .Reset(reset),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Address(ALUResult), 
        .DataRead(DMDataRead), 
        .Data(ReadData2)
    );

    EXT _ext(
        .imm16(imm16),
        .ExtSel(ExtSel),
        .imm32(EXTData)
    );
endmodule
