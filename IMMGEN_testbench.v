`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2022 09:44:45 PM
// Design Name: 
// Module Name: IMMGEN_testbench
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


module IMMGEN_testbench();
reg[31:0] inst_imm;
reg[2:0] immsel_g;
wire[31:0] immgen_out;

IMMGEN dut(
.inst_imm(inst_imm),
.immsel_g(immsel_g),
.immgen_out(immgen_out)
);

initial begin// things other than imm is not important right now, I'll set them all to 0
immsel_g = 0;
inst_imm = 32'h00001000;//U type, imm should be 1
#5 inst_imm = 32'h80000000;//to see no sign extended for U type
#5; 
immsel_g = 1;
inst_imm = 32'b0111_1111_1110_00000000_000000000000;//J type to see the specific bits location change, specifically 10 to 1
#5 inst_imm = 32'b1111_1111_1110_00000000_000000000000;// same thing but to see the sign extended
#5;
immsel_g = 2;
inst_imm = 32'b0111_1111_0000_11111111_000000000000;//I type to see the first 12 bits as imm, all 1s surrounding the 4 0s, should be clear enough
#5 inst_imm = 32'b1111_1111_0000_11111111_000000000000;//same thing but to see the sign extended
#5; 
immsel_g = 3;
inst_imm = 32'b0000000_0000000000000_00001_0000000;//B type to see the second imm bit is at instruction[7]
#5 inst_imm = 32'b1000000_0000000000000_00001_0000000;// same thing but to see the sign extended
#5;
immsel_g = 4;
inst_imm = 32'b0111111_0000000000000_11111_0000000;//S type, to see the imm is instruction[31:25] and instruction[11:7] combined
#5 inst_imm = 32'b1111111_0000000000000_11111_0000000;//to see the sign extended
#5 immsel_g = 5;//out of range, output 0
#5 $stop;

end







endmodule
