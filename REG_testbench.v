`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2022 06:38:16 PM
// Design Name: 
// Module Name: REG_testbench
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


module REG_testbench();
reg clk, rst, regwr;
reg[31:0] inst, wrdata;
wire[31:0] rs1data, rs2data;
wire wb_update;

REG dut(
.clk(clk),
.rst(rst),
.regwr(regwr),
.inst(inst),
.wrdata(wrdata),
.rs1data(rs1data),
.rs2data(rs2data)
);


initial begin
clk = 0;
rst = 1;
regwr = 0;
end

always #5 clk = ~clk;

initial begin
#5 inst = 32'b000000000000_00110_00111_000_00010_0110011;//rs1 = r6, rs2 = r7, rd = r1, this is ADD just for testing?
#5 rst = 0;
#5 wrdata = 32'hffffffff;
#5 regwr = 1;
end



























endmodule
