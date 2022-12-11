`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 10:04:18 PM
// Design Name: 
// Module Name: SUBPC
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


module SUBPC(
input[31:0] PC4,
output[31:0] JAL_store
    );
    
assign JAL_store = PC4-32'h01000000;    

endmodule
