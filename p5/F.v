`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:09:09 08/04/2021 
// Design Name: 
// Module Name:    F 
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
module F(
    input clk,
    input Reset,
    input Enable,
    input [31:0] next_pc,
    input [1:0] PCSel,
    output reg[31:0] D_instr_reg,
    output reg[31:0] D_PC_reg
    );
	
    initial begin 
        D_instr_reg = 0;
        D_PC_reg = 0;
    end
    wire [31:0] D_instr;
    wire [31:0] D_PC;
    // next_PC = PCSel:00 -> D_PC + 4 ：
    //             next_pc
	MUX_4_32 _mux_pc(D_PC + 4, next_pc, 32'b0, 32'b0, PCSel, next_pc);

    PC _pc(clk, Reset. Enable, next_pc, D_PC);

    IM _im(D_PC, D_instr)；

    // IF/ID 
    always @(posedge clk) begin
        if (reset) begin
            D_instr_reg <= D_instr;
            D_PC_reg <= D_reg;
        end
        else begin 
            D_instr_reg <= 0;
            D_PC_reg <= 0;
        end

    end
endmodule
