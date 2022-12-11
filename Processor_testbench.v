`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 04:42:20 PM
// Design Name: 
// Module Name: Processor_testbench
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


module Processor_testbench();

reg clk;
reg reset;
wire complete;
wire[31:0] memread_data;
wire[31:0] memwrite_data;


Processor test(
.clk(clk),
.reset(reset),
.complete(complete),
.memread_data(memread_data),
.memwrite_data(memwrite_data)
);

initial begin
clk = 0;
reset = 1;

end

always #5 clk = ~clk;

initial begin
#10; 
reset = 0;
end
/*
initial begin

if (complete == 1) begin
    $finish;
end

end
*/

endmodule
