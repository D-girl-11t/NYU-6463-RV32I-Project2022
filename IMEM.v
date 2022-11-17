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
output reg instrf_update
    );

parameter IMEM_size = 2048;

reg[31:0] rom_words [0:(IMEM_size/4)-1];

reg[7:0] IMEM0[0:(IMEM_size/4)-1];  
reg[7:0] IMEM1[0:(IMEM_size/4)-1];  
reg[7:0] IMEM2[0:(IMEM_size/4)-1];  
reg[7:0] IMEM3[0:(IMEM_size/4)-1];

initial begin
rom_words[0]= 32'b0000001000_00001_000_00010_0000011;

rom_words[511] = 32'hffffffff;
end


/*
initial begin
$readmemh("main.mem", rom_words);
end
*/

always@(*) begin
if(instrfetch) begin
    if(addr_imem[31:12] == 20'b0000_0001_0000_0000_0000)
        instr = {IMEM0[addr_imem[11:0]>>2],IMEM1[addr_imem[11:0]>>2],IMEM2[addr_imem[11:0]>>2],IMEM3[addr_imem[11:0]>>2]};// this is big endian  
end
end

    
always@(posedge clk) begin
if(instrfetch) begin
    instrf_update = 1'b1;
    if(addr_imem[31:12] == 20'b0000_0001_0000_0000_0000) begin// instruction memory begins at 0x01000000
        IMEM0[addr_imem[11:0]>>2] = rom_words[addr_imem[11:0]>>2][31:24];
        IMEM1[addr_imem[11:0]>>2] = rom_words[addr_imem[11:0]>>2][23:16];
        IMEM2[addr_imem[11:0]>>2] = rom_words[addr_imem[11:0]>>2][15:8];
        IMEM3[addr_imem[11:0]>>2] = rom_words[addr_imem[11:0]>>2][7:0];  //address incremented by 4 and we only have 512 addresses, so the addresses needs to be divided by 4  
    end
    else 
        instr = 32'h0;    
end
else 
instrf_update = 1'b0;
end    
    
endmodule
