`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2022 10:36:31 PM
// Design Name: 
// Module Name: PC_testbench
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


module PC_testbench();
reg clk, write, rst;
reg [31:0] new_count; 
wire[31:0] addr;
wire pc_update;

programcounter dut(
.clk(clk),
.write(write),
.rst(rst),
.new_count(new_count),
.pc_update(pc_update),
.addr(addr)
);

initial begin
clk = 0;
rst = 1;
write = 0;
new_count = 32'h00000000;
end

always #5 clk = ~clk;

initial begin
#15 
rst = 0;
#5;
write = 1;
#20 new_count = 32'hffffffff;
#10 write = 0;
end






endmodule
