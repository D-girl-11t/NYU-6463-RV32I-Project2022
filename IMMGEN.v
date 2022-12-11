`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 08:01:28 PM
// Design Name: 
// Module Name: IMMGEN
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


module IMMGEN(
input[31:0] inst_imm,
input[2:0] immsel_g,
output reg[31:0] immgen_out
    );
    
always@(*) begin// R type doesn't have immdeiate
case(immsel_g)
3'b000: immgen_out <= {inst_imm[31:12],12'b0};//U type
3'b001: immgen_out <= {{12{inst_imm[31]}},inst_imm[31],inst_imm[19:12],inst_imm[20],inst_imm[30:21]};//J type, sign extended
3'b010: immgen_out <= {{20{inst_imm[31]}},inst_imm[31:20]};//I type, sign extended
3'b011: immgen_out <= {{20{inst_imm[31]}},inst_imm[31],inst_imm[7],inst_imm[30:25],inst_imm[11:8]};//B type, sign extended 
3'b100: immgen_out <= {{20{inst_imm[31]}},inst_imm[31:25],inst_imm[11:7]};//S type, sign extended
default: immgen_out <= 0;   
endcase
end    
       
endmodule
