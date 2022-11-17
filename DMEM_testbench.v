`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/17/2022 01:17:15 PM
// Design Name: 
// Module Name: DMEM_testbench
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


module DMEM_testbench();
reg clk, memread, memwrite;
reg[1:0] data_type;
reg[31:0] addr, wr_data;
wire[31:0] out_data;

DMEM dut(
.clk(clk),
.memread(memread),
.memwrite(memwrite),
.addr(addr),
.wr_data(wr_data),
.out_data(out_data),
.data_type(data_type)
);

initial begin
clk = 0;
addr = 32'h00100004;
memread = 1;
wr_data = 32'h12345678;
data_type = 1;
end

always #5 clk = ~clk;

initial begin
#5 memwrite = 1;
#10 addr = 32'h0000000c;
#10 addr = 32'h0010000c;

end


endmodule
