`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 04:59:52 PM
// Design Name: 
// Module Name: PCSUM
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


module PCSUM(
input[31:0] pc_in_s, imm_in_s,
output[31:0] pc_out_s //s for sum module
    );
    
assign pc_out_s = pc_in_s + imm_in_s;                           
    
endmodule
