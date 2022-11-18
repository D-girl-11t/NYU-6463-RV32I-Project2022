`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 12:05:45 AM
// Design Name: 
// Module Name: DECODER_testbench
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


module DECODER_testbench();

reg[31:0] instruction;
wire[4:0] ALU_op_d;
wire[2:0] immsel;
wire halt;


DECODER dut(

.instruction(instruction),
.ALU_op_d(ALU_op_d),
.immsel(immsel),
.halt(halt)
);
/*
initial begin
clk = 0;
end

always #5 clk = ~clk;
*/
initial begin
instruction = 32'b000000000000_00110_00111_000_00010_0110011;// this is ADD rd = 00010, rs1 = 00111, rs2 = 00110, so aluop should be 2
#10 instruction = 32'b0000000000000011000111000_00010_1101111;// this is JAL, aluop should be same = 2
#10 instruction = 32'b000000000000_00110_00111_000_00010_1100011;// this is BNE
end

endmodule
