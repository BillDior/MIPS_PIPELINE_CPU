`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:11:32 08/02/2021 
// Design Name: 
// Module Name:    Controller_realize 
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
`define R 6'b000000
`define lw 6'b100011
`define sw 6'b101011
`define lui 6'b001111
`define ori 6'b001101
`define beq 6'b000100
`define jal 6'b000011
`define addu_func 6'b100001
`define subu_func 6'b100011
`define jr_func 6'b001000
`define jalr_func 6'b001001
module Controller_realize(
    input [31:0] instr,
    output [2:0] ALUopInput,
    output [1:0] RegDst,
    output  ALUSrc,
    output  RegWrite,
    output  MemRead,
    output  MemWrite,
    output  [1:0] MemToReg,
    output  [1:0] ExtSel,
    output  rs,
    output  rt,
    output  BranchImm26,
    output  BranchReg,
    output  BranchExt32,
    output  Jump,
    output  Branch,
    output  BorJ,
    output  RegToWrite
    // output  MoveHigh (new Extsel = old ExtSel + MoveHigh)
    );

    wire [5:0] op;
    wire [5:0] func;
    wire [4:0] rs;
    wire [4:0] rt;
    INSTR_SPLITTER _D_spiltter (
        .Instr(D_instr),
        .op(op),
        .rs(rs),
        .rt(rt),
        .func(func),
        .imm16(imm16),
        .imm26(imm26)
    )

    wire R ;
    wire lw ;
    wire sw ;
    wire beq ;
    wire jr;
    wire jal ;
    wire lui ;
    wire ori ;
    wire jalr ;
    wire addu ;
    wire subu ;
    

    assign   R = op == `R;
    assign   ori = op == `ori;
    assign    lw = op == `lw;
    assign    sw = op == `sw;
    assign    lui = op == `lui;
    assign    beq = op == `beq;
    assign    jal = op == `jal;


    assign jr =     (R && func == `jr_func);
    // assign jalr =   (R && func == `jalr_func);
    assign addu =   (R && func == `addu_func);
    assign subu =   (R && func == `subu_func);
    // assign sll =    (Rtype && func == 6'b000000);
    
    assign signed_ext =  (lw || sw || beq);

    assign ALUSrc = (ori || lw || sw || lui);
    assign ALU_add = (lw || sw);
    assign ALU_sub = beq;
    assign ALU_R = R;
    assign ALU_or = (ori || lui); // get imm
    assign ExtSel = lui ? 2'b10:
                    signed_ext? 2'b01:
                    2'b00 ;
    assign MemRead = lw;
    assign MemToReg = lw ? 2'b01:
                      jal? 2'b10 :
                      2'b00 ; 
    assign RegWrite = (R || ori || lw || lui || jal);
    assign MemWrite = sw;

    assign ALUopInput = ALU_R ? 3'b010 :
                        ALU_add ? 3'b000 :
                        ALU_sub ? 3'b001 :
                        ALU_or ? 3'b011 :
                        3'b111;
    assign RegDst = R? 2'b01: // from rd
                    jal ? 2'b10: // 5'b11111  to save pc + 4            
                         2'b00 ; // from rt;

    assign BranchImm26 = jal;
    assign BranchReg = jr;
    assign BranchExt32 = beq;

    assign Jump = (j || jal || jr);
    assign Branch = beq;
    assign BorJ = Jump || Branch;

    MUX_4 _mux_reg2Write(
        .data0(rt),
        .data1(rd),
        .data2(5'b11111), // for jal
        .data3(5'b0),
        .selector(RegDst), 
        .out(RegToWrite) 
    );
endmodule
