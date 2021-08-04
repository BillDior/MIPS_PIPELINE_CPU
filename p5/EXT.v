`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:53:34 08/01/2021 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] imm16,
    input [1:0] ExtSel,
    output reg[31:0] imm32
    );

    always @(*) begin
        case(ExtSel)
            2'b00:begin // zero extend 16 to 32
                imm32 <= {{16{1'b0}}, imm16};
            end
            2'b01:begin // signed extend 16 to 32
                imm32 <= {{16{imm16[15]}}, imm16};
            end
            2'b10:begin // move high extend
                imm32 <= {imm16, {{16{1'b0}}}};
            end
        endcase
    end

endmodule
