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
    input [31:0] next_pc,
    input [1:0] PCSrc,
    input stall, 
    output [31:0] F_instr,
    output [31:0] F_PC
    );
	

    // next_PC = PCSel:00 -> D_PC + 4 ：
    //             next_pc
	// MUX_4_32 _mux_pc(F_PC + 4, next_pc, 32'b0, 32'b0, PCSel, next_pc);

    assign next_pc = PCSrc? next_pc: F_PC + 4; // 
    PC _pc(clk, Reset, stall, next_pc, F_PC);

    IM _im(D_PC, F_instr)；

    // IF/ID 

endmodule 

module F_REG(
    input clk,
    input reset,
    input stall,
    input[31:0] F_instr,
    input[31:0] F_PC,
    output reg [31:0]D_instr_reg,
    output reg [31:0]D_PC_reg
)
    initial begin 
        D_instr_reg = 0;
        D_PC_reg = 0;
    end
    always @(posedge clk) begin
        if (reset || stall ) begin
            D_instr_reg <= 0;
            D_PC_reg <= 0;
        end
        else if begin 
            D_instr_reg <= F_instr;
            D_PC_reg <= F_PC;
        end

    end
endmodule
