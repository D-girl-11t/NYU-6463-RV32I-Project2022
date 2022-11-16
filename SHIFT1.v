`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 05:00:06 PM
// Design Name: 
// Module Name: SHIFT1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SHIFT1(
input[31:0] imm,
output[31:0] imm_out
    );
    
assign imm_out = {imm[30:0],1'b0};
    
endmodule
