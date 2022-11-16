`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2022 07:12:27 PM
// Design Name: 
// Module Name: MUX_testbench
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


module MUX_testbench();
reg sel_mux2;
reg[1:0] sel_mux3;
reg[31:0] in_mux2_a, in_mux2_b, in_mux3_a, in_mux3_b, in_mux3_c;
wire[31:0] out_mux2, out_mux3;

MUX2 dut1(
.sel_mux2(sel_mux2),
.in_mux2_a(in_mux2_a),
.in_mux2_b(in_mux2_b),
.out_mux2(out_mux2)
);

MUX3 dut2(
.sel_mux3(sel_mux3),
.in_mux3_a(in_mux3_a),
.in_mux3_b(in_mux3_b),
.in_mux3_c(in_mux3_c),
.out_mux3(out_mux3)
);

initial begin
sel_mux2 = 0;
sel_mux3 = 2;

in_mux2_a = 32'd10;
in_mux2_b = 32'd20;
in_mux3_a = 32'd30;
in_mux3_b = 32'd40;
in_mux3_c = 32'd50;
end












endmodule
