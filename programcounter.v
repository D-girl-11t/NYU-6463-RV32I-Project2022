`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/11/2022 05:50:12 PM
// Design Name: 
// Module Name: programcounter
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


module programcounter(
input clk, write, rst,
input[31:0] new_count, // for immediate
output[31:0] addr,
output reg pc_update
    );

reg[31:0] pc = 32'h01000000;
    
always@(posedge clk) begin
   if(!rst) begin
    if(write) begin
        addr <= new_count;
        pc_update <= 1'b1;
    end
    else begin
        addr <= addr;
        pc_update <= 1'b0;
    end
   end 
   else begin //this is reset
    addr <= pc;
    pc_update <= 1'b0;
   end
end    
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
