`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 12:18:34 AM
// Design Name: 
// Module Name: DECODER_ALU
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


module DECODER_ALU(
input[31:0] instruction,
input clk, rst, regwr, memread,
output[31:0] data, regwrdata
    );
    
wire[31:0] rs1, rs2;
wire[4:0] aluop;
wire[2:0] immsel;
wire zero, halt;
wire wbupdate;
wire memread, memwrite;
wire[31:0] regwrdata;    
DECODER de(
.instruction(instruction),
.ALU_op_d(aluop),
.immsel(immsel),
.halt(halt)
);


ALU alu(
.ALU_op(aluop),
.input1(rs1),
.input2(rs2),
.alu_out(data),
.zero(zero)
);

REG regi(
.inst(instruction),
.rst(rst),
.regwr(regwr),
.clk(clk),
.wrdata(regwrdata),
.rs1data(rs1),
.rs2data(),
.wb_update(wbupdate)
);    

IMMGEN imm(
.inst_imm(instruction),
.immsel_g(immsel),
.immgen_out(rs2)
);

DMEM dmem(
.clk(clk),
.memread(memread),
.memwrite(memwrite),
.addr(data),
.wr_data(),
.out_data(regwrdata)
);    
  
endmodule
