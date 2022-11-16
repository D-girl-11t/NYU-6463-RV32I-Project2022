`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2022 07:03:43 PM
// Design Name: 
// Module Name: MUX3
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


module MUX3(
input[1:0] sel_mux3,
input [31:0] in_mux3_a, in_mux3_b, in_mux3_c,
output[31:0] out_mux3
    );
/*    
always@(*)begin
case(sel_mux3)
2'b00: out_mux3 <= in_mux3_a;
2'b01: out_mux3 <= in_mux3_b;
2'b10: out_mux3 <= in_mux3_c ;
default: out_mux3 <= 32'h00000000;
endcase
end
*/   
assign out_mux3 = (sel_mux3 == 0)? in_mux3_a: (sel_mux3 == 1)? in_mux3_b : (sel_mux3 == 2)? in_mux3_c : 32'h00000000;    
   
    
endmodule
