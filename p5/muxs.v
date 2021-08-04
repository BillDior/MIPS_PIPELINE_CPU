`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:46:48 08/02/2021 
// Design Name: 
// Module Name:    muxs 
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
module MUX_NPC( // 
    input [31:0] PC,
    input [25:0] imm26,
    input [31:0] Reg32,
    input [31:0] Ext32,
    input BranchExt32,
    input BranchImm26, 
    input BranchReg,
    input EuqalSign,
    output [31:0] next_pc,
    output [31:0] pc_add_4
    );

    assign pc_add_4  = PC + 4;
    assign next_pc = BranchExt32 && EuqalSign ? pc_add_4 + (Ext32 << 2):
                     BranchImm26 ? {PC[31:28], imm26, 2'b00}:
                     BranchReg ? Reg32 :
                     pc_add_4 ;


endmodule

module MUX_4(
    input [4:0] data0,
    input [4:0] data1,
    input [4:0] data2,
    input [4:0] data3,
    input [1:0] selector, 
    output [4:0] out   
);

	 reg [4:0] tmp;
    always@(*) begin 
        case (selector)
            2'b00:begin
                tmp = data0;
            end
            2'b01:begin
                tmp = data1;
            end
            2'b10:begin
                tmp = data2;
            end
            2'b11:begin
                tmp = data3;
            end
        endcase
	  end
	  
	  assign out = tmp;
endmodule

module MUX_4_32(
    input [31:0] data0,
    input [31:0] data1,
    input [31:0] data2,
    input [31:0] data3,
    input [1:0] selector, 
    output [31:0] out   
);

	 reg [31:0] tmp;
    always@(*) begin 
        case (selector)
            2'b00:begin
                tmp = data0;
            end
            2'b01:begin
                tmp = data1;
            end
            2'b10:begin
                tmp = data2;
            end
            2'b11:begin
                tmp = data3;
            end
        endcase
	  end
	  
	  assign out = tmp;
endmodule

module MUX_8(
    input [5:0] data0,
    input [5:0] data1,
    input [5:0] data2,
    input [5:0] data3,
    input [5:0] data4,
    input [5:0] data5,
    input [5:0] data6,
    input [5:0] data7,
    input [2:0] selector, 
    output reg [5:0] out   
);

    always@(*) begin 
        case (selector)
            3'b000:begin
                assign out = data0;
            end
            3'b001:begin
                assign out = data1;
            end
            3'b010:begin
                assign out = data2;
            end
            3'b011:begin
                assign out = data3;
            end
            3'b100:begin
                assign out = data4;
            end
            3'b101:begin
                assign out = data5;
            end
            3'b110:begin
                assign out = data6;
            end
            3'b111:begin
                assign out = data7;
            end
        endcase
	  end

endmodule

module INSTR_SPLITTER(
    input [31:0] Instr,
    output [4:0] op,
    output [4:0] rs, 
    output [4:0] rt, 
    output [4:0] rd,
    output [15:0] imm16, 
    output [25:0] imm26,
    output [4:0] shamt, 
    output [4:0] func
)

    assign op = Instr[31:26];
    assign rs = Instr[25:21];
    assign rt = Instr[20:16];
    assign rd = Instr[15:11];
    assign shamt = Instr[10:6];
    assign func = Instr[5:0];
    assign imm16 = Instr[15:0];
    assign imm26 = Instr[25:0];

endmodule