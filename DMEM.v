`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2022 01:50:36 PM
// Design Name: 
// Module Name: DMEM
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


module DMEM(
input clk, memread, memwrite,
input[31:0] addr, wr_data,
output reg[31:0] out_data
    );

parameter DMEMsize = 4096;
wire[31:0] addr_wa;//word addressed 
reg[31:0] DMEM[0:(DMEMsize/4)-1];
reg[31:0] N1 = 32'h00000000;
reg[31:0] N2 = 32'h16726992;

assign addr_wa = (addr[31:0] >> 2); //this ram is word addressed, so all the addresses from alu and pc will need to be divided by 4

always@(*) begin
if(memread) begin
    if(addr_wa == 32'h00040000)//0x00100000 = 0x00040000 word address
        out_data = N1;
    else if(addr_wa == 32'h00040001)//word address so 0x00040001
        out_data = N2;
    else if(addr_wa == 32'h00000002)//testing
        out_data = 32'h00000088;
    else
        out_data = DMEM[addr_wa];
end
end

always@(posedge clk) begin
if(memwrite) 
    DMEM[addr] = wr_data;
end   

//should we add byte/halfword/word selection here?
endmodule
