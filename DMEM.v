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
input[1:0] data_type,
output reg[31:0] out_data
    );

parameter DMEMsize = 4096;
wire[31:0] addr_wa;//word addressed 
reg[31:0] DMEM[0:(DMEMsize/4)-1];
reg[31:0] N1 = 32'h00000000;
reg[31:0] N2 = 32'h16726992;

initial begin
DMEM[0] = N1;
DMEM[1] = N2;
DMEM[2] = 32'h00000088;//this is for testing
end

assign addr_wa = (addr[31:0] >> 2); //this ram is word addressed, so all the addresses from alu and pc will need to be divided by 4

always@(*) begin
if(memread) begin
    if(addr_wa[31:16] == 16'h0004)//0x00100000 = 0x00040000 word addressed, this is to ensure the address begins at 0x00100000
        case(data_type)
        2'b00: out_data = DMEM[addr_wa[15:0]][7:0];// read byte, =LB
                                                   //the 4096 address will be represented by the lower 16 bits of the address from 0 to 3ffc
                                                   //3ffc is 0011111111111100 so with addr_wa it will become 0000111111111111 = 4095
        2'b01: out_data = DMEM[addr_wa[15:0]][15:0];// read half word, =LH
        2'b10: out_data = DMEM[addr_wa[15:0]];// read word, =LW  
        default: out_data = DMEM[addr_wa[15:0]];
        endcase
    else
        out_data = 0;                                           
end
end


always@(posedge clk) begin
if(memwrite)
    case(data_type) 
    2'b00: DMEM[addr_wa] = wr_data[7:0];//SB
    2'b01: DMEM[addr_wa] = wr_data[15:0];//SH
    2'b10: DMEM[addr_wa] = wr_data;//SW
    default: DMEM[addr_wa] = wr_data;
    endcase
end   

//should we add byte/halfword/word selection here?
endmodule
