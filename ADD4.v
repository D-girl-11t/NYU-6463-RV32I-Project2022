`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 04:59:27 PM
// Design Name: 
// Module Name: ADD4
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


module ADD4(
input[31:0] pc_in_a,
output[31:0] pc_out_a//a for add4 module
    );
    
assign pc_out_a = pc_in_a + 3'd4;

endmodule
