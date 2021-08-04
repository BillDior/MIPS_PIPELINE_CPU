`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:27:11 08/01/2021 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] reg1,
    input [31:0] reg2,
    input [3:0] aluCtrl,
    output reg[31:0] Result,
    output EqualSign,
    output lessSign
    );

    assign EqualSign = (reg1 == reg2);
    
    always @(*) begin
        case (aluCtrl)
            4'b0010: begin
                Result = reg1 + reg2;
            end
            4'b0110: begin
                Result = reg1 - reg2;
            end
            4'b0001: begin 
                Result = reg1 | reg2;
            end
            4'b0100: begin 
                Result = reg1 << (reg2[4:0]);
            end
            default: begin
                Result = 0;
            end
        endcase
    end



endmodule
