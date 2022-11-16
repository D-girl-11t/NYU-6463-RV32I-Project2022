`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 05:16:43 PM
// Design Name: 
// Module Name: ALU_testbench
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


module ALU_testbench();
reg[4:0] ALU_op;
reg[31:0] input1;
reg[31:0] input2;

wire[31:0] alu_out;
wire zero;



ALU dut (
.ALU_op(ALU_op),
.input1(input1),
.input2(input2),
.alu_out(alu_out),
.zero(zero)
);

initial begin
ALU_op = 5'b01111;
input1 = 32'h0000000f;
input2 = 32'h0000000f;


end

endmodule
