`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2022 05:51:57 PM
// Design Name: 
// Module Name: REG
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


module REG(
input wb, rst, regwr, clk,
input[31:0] inst, wrdata,
output reg [31:0] rs1data, rs2data,
output reg wb_comp
    );
wire[4:0] rd_reg1_addr, rd_reg2_addr;
wire[4:0] wr_addr;
reg[31:0] regi[0:31];

initial begin
regi[5'd0] = 32'h00000000;
regi[5'd1] = 32'h00000000;
regi[5'd2] = 32'h00000000;
regi[5'd3] = 32'h00000000;
regi[5'd4] = 32'h00000000;
regi[5'd5] = 32'h00000000;
regi[5'd6] = 32'h00000000;
regi[5'd7] = 32'h00000000;
regi[5'd8] = 32'h00000000;
regi[5'd9] = 32'h00000000;
regi[5'd10] = 32'h00000000;
regi[5'd11] = 32'h00000000;
regi[5'd12] = 32'h00000000;
regi[5'd13] = 32'h00000000;
regi[5'd14] = 32'h00000000;
regi[5'd15] = 32'h00000000;
regi[5'd16] = 32'h00000000;
regi[5'd17] = 32'h00000000;
regi[5'd18] = 32'h00000000;
regi[5'd19] = 32'h00000000;
regi[5'd20] = 32'h00000000;
regi[5'd21] = 32'h00000000;
regi[5'd22] = 32'h00000000;
regi[5'd23] = 32'h00000000;
regi[5'd24] = 32'h00000000;
regi[5'd25] = 32'h00000000;
regi[5'd26] = 32'h00000000;
regi[5'd27] = 32'h00000000;
regi[5'd28] = 32'h00000000;
regi[5'd29] = 32'h00000000;
regi[5'd30] = 32'h00000000;
regi[5'd31] = 32'h00000000;
end


assign rd_reg1_addr = inst[19:15];
assign rd_reg2_addr = inst[24:20];
assign wr_addr = inst[11:7];

always@(posedge clk) begin
    if(rst) begin
        wb_comp <= 1'b0;
        regi[5'd0] = 32'h00000000;
        regi[5'd1] = 32'h00000000;
        regi[5'd2] = 32'h00000000;
        regi[5'd3] = 32'h00000000;
        regi[5'd4] = 32'h00000000;
        regi[5'd5] = 32'h00000000;
        regi[5'd6] = 32'h00000000;
        regi[5'd7] = 32'h00000000;
        regi[5'd8] = 32'h00000000;
        regi[5'd9] = 32'h00000000;
        regi[5'd10] = 32'h00000000;
        regi[5'd11] = 32'h00000000;
        regi[5'd12] = 32'h00000000;
        regi[5'd13] = 32'h00000000;
        regi[5'd14] = 32'h00000000;
        regi[5'd15] = 32'h00000000;
        regi[5'd16] = 32'h00000000;
        regi[5'd17] = 32'h00000000;
        regi[5'd18] = 32'h00000000;
        regi[5'd19] = 32'h00000000;
        regi[5'd20] = 32'h00000000;
        regi[5'd21] = 32'h00000000;
        regi[5'd22] = 32'h00000000;
        regi[5'd23] = 32'h00000000;
        regi[5'd24] = 32'h00000000;
        regi[5'd25] = 32'h00000000;
        regi[5'd26] = 32'h00000000;
        regi[5'd27] = 32'h00000000;
        regi[5'd28] = 32'h00000000;
        regi[5'd29] = 32'h00000000;
        regi[5'd30] = 32'h00000000;
        regi[5'd31] = 32'h00000000;
    end
    else begin
        if (wb) begin
            if (regwr) begin
                if(wr_addr != 0)
                    regi[wr_addr] <= wrdata;
                else 
                    regi[0] <= 0;
                wb_comp <= 1'b1;
            end
            else
                regi[0] <= 0;
        end
        else
            wb_comp <= 1'b0;
    end
end


always@(*) begin
    rs1data <= regi[rd_reg1_addr];
    rs2data <= regi[rd_reg2_addr];    
end
    
   
endmodule
