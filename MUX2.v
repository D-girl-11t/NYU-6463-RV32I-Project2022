`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2022 07:03:27 PM
// Design Name: 
// Module Name: MUX2
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


module MUX2(
input sel_mux2,
input[31:0] in_mux2_a, in_mux2_b,
output[31:0] out_mux2
    );

assign out_mux2 = (sel_mux2==0)? in_mux2_a : in_mux2_b;//sel =0 output = a, sel = 1 output = b

    
endmodule
