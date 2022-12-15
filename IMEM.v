`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2022 04:04:48 PM
// Design Name: 
// Module Name: IMEM
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


module IMEM(
input clk, instrfetch,
input[31:0] addr_imem,
output reg[31:0] instr,
output reg instr_fetched
    );

parameter IMEM_size = 2048;

reg[31:0] IMEM [0:(IMEM_size/4)-1];

initial begin
    $readmemh("euclidean_imem.mem", IMEM);
    //$readmemh("ledtest_imem.mem", IMEM);
    //$readmemh("odd_imem.mem", IMEM);
end

always@(posedge clk) begin
    if(instrfetch) begin
        if(addr_imem[31:12] == 20'b0000_0001_0000_0000_0000) begin
            instr <= IMEM[addr_imem[11:0]>>2];// this is big endian
            instr_fetched <= 1'b1;
        end
        else
            instr_fetched <= 1'b0;
    end
    else begin
        instr <= instr;
        instr_fetched <= 1'b0;
    end
end

    
endmodule
