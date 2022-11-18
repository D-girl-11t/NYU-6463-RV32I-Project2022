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
ALU_op = 5'b01110;//this is SLL, for SLLI we need to connect to the IMMGEN, which I did, but not in this testbench
input1 = 32'h0000000f;
input2 = 32'h0000000f;// imm will be 15
end

initial begin
#10; 
input2 = 32'hf000000f;// added signed bits in front, signed = -268435441, unsigned = 4026531855 
ALU_op = 5'b00101;//this is BLT, with signed arguments, 15>-268435441, so zero should be 0
#10 ALU_op = 5'b00111;// this is BLTU, unsigned branch if less then, 15< 4026531855 so zero should be 1, we can see the difference between BLT and BLTU
#10 ALU_op = 5'b00010;//JAL,JALR,LB,LH,LBU,LHU,LW,SB,SH,SW,ADD,ADDI
end



endmodule
