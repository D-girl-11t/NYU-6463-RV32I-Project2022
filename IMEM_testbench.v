`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 08:57:06 PM
// Design Name: 
// Module Name: IMEM_testbench
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


module IMEM_testbench();
reg clk, instrfetch;
reg[31:0] addr_imem;
wire instrf_update;
wire[31:0] instr;


IMEM dut(
.clk(clk),
.instrfetch(instrfetch),
.addr_imem(addr_imem),
.instrf_update(instrf_update),
.instr(instr)
);


initial begin
clk = 0;
instrfetch = 1;
addr_imem = 32'h0;
end


always #5 clk = ~clk;


initial begin
#10 addr_imem = 32'h01000000;
#10 addr_imem = 32'h010007fc;
#10 instrfetch = 0;
#10 addr_imem = 32'h01000000;
#10 instrfetch = 1;

end

endmodule
