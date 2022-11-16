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
input rst, regwr, clk,
input[31:0] inst, wrdata,
output reg [31:0] rs1data, rs2data,
output reg wb_update
    );
wire[4:0] rd_reg1_addr, rd_reg2_addr;
wire[4:0] wr_addr;

reg[31:0] r0=0;
reg[31:0] r1=0;
reg[31:0] r2=0;
reg[31:0] r3=0;
reg[31:0] r4=0;
reg[31:0] r5=0;
reg[31:0] r6=0;
reg[31:0] r7=0;
reg[31:0] r8=0;
reg[31:0] r9=0;
reg[31:0] r10=0;
reg[31:0] r11=0;
reg[31:0] r12=0;
reg[31:0] r13=0;
reg[31:0] r14=0;
reg[31:0] r15=0;
reg[31:0] r16=0;
reg[31:0] r17=0;
reg[31:0] r18=0;
reg[31:0] r19=0;
reg[31:0] r20=0;
reg[31:0] r21=0;
reg[31:0] r22=0;
reg[31:0] r23=0;
reg[31:0] r24=0;
reg[31:0] r25=0;
reg[31:0] r26=0;
reg[31:0] r27=0;
reg[31:0] r28=0;
reg[31:0] r29=0;
reg[31:0] r30=0;
reg[31:0] r31=0;

assign rd_reg1_addr = inst[19:15];
assign rd_reg2_addr = inst[24:20];
assign wr_addr = inst[11:7];

always@(posedge clk) begin
    if(rst) begin
    wb_update = 0;
    r1 <= 32'h00000000;
    r2 <= 32'h00000000;
    r3 <= 32'h00000000;
    r4 <= 32'h00000000;
    r5 <= 32'h00000000;
    r6 <= 32'h00000000;
    r7 <= 32'h00000000;
    r8 <= 32'h00000000;
    r9 <= 32'h00000000;
    r10 <= 32'h00000000;
    r11 <= 32'h00000000;
    r12 <= 32'h00000000;
    r13 <= 32'h00000000;
    r14 <= 32'h00000000;
    r15 <= 32'h00000000;
    r16 <= 32'h00000000;
    r17 <= 32'h00000000;
    r18 <= 32'h00000000;
    r19 <= 32'h00000000;
    r20 <= 32'h00000000;
    r21 <= 32'h00000000;
    r22 <= 32'h00000000;
    r23 <= 32'h00000000;
    r24 <= 32'h00000000;
    r25 <= 32'h00000000;
    r26 <= 32'h00000000;
    r27 <= 32'h00000000;
    r28 <= 32'h00000000;
    r29 <= 32'h00000000;
    r30 <= 32'h00000000;
    r31 <= 32'h00000000;
    end
    else begin
        if(regwr) begin
            case(wr_addr)
            5'd1: r1 <= wrdata;
            5'd2: r2 <= wrdata;
            5'd3: r3 <= wrdata;
            5'd4: r4 <= wrdata;
            5'd5: r5 <= wrdata;
            5'd6: r6 <= wrdata;
            5'd7: r7 <= wrdata;
            5'd8: r8 <= wrdata;
            5'd9: r9 <= wrdata;
            5'd10: r10 <= wrdata;
            5'd11: r11 <= wrdata;
            5'd12: r12 <= wrdata;
            5'd13: r13 <= wrdata;
            5'd14: r14 <= wrdata;
            5'd15: r15 <= wrdata;
            5'd16: r16 <= wrdata;
            5'd17: r17 <= wrdata;
            5'd18: r18 <= wrdata;
            5'd19: r19 <= wrdata;
            5'd20: r20 <= wrdata;
            5'd21: r21 <= wrdata;
            5'd22: r22 <= wrdata;
            5'd23: r23 <= wrdata;
            5'd24: r24 <= wrdata;
            5'd25: r25 <= wrdata;
            5'd26: r26 <= wrdata;
            5'd27: r27 <= wrdata;
            5'd28: r28 <= wrdata;
            5'd29: r29 <= wrdata;
            5'd30: r30 <= wrdata;
            5'd31: r31 <= wrdata;
            default: r0 <= 32'h00000000;
            endcase
            wb_update = 1'b1;
        end
        else
            wb_update = 1'b0;
    end
end


always@(posedge clk) begin
case(rd_reg1_addr)
5'd0: rs1data <= r0;
5'd1: rs1data <=  r1;
5'd2: rs1data <=  r2;
5'd3: rs1data <=  r3;
5'd4: rs1data <=  r4;
5'd5: rs1data <=  r5;
5'd6: rs1data <=  r6; 
5'd7: rs1data <=  r7;
5'd8: rs1data <=  r8; 
5'd9: rs1data <=  r9; 
5'd10: rs1data <= r10; 
5'd11: rs1data <= r11; 
5'd12: rs1data <= r12; 
5'd13: rs1data <= r13; 
5'd14: rs1data <= r14; 
5'd15: rs1data <= r15; 
5'd16: rs1data <= r16; 
5'd17: rs1data <= r17; 
5'd18: rs1data <= r18; 
5'd19: rs1data <= r19; 
5'd20: rs1data <= r20; 
5'd21: rs1data <= r21; 
5'd22: rs1data <= r22; 
5'd23: rs1data <= r23;
5'd24: rs1data <= r24; 
5'd25: rs1data <= r25; 
5'd26: rs1data <= r26; 
5'd27: rs1data <= r27; 
5'd28: rs1data <= r28; 
5'd29: rs1data <= r29; 
5'd30: rs1data <= r30; 
5'd31: rs1data <= r31;
endcase
end                       
                
always@(posedge clk) begin
case(rd_reg2_addr)
5'd0: rs2data <= r0;
5'd1: rs2data <=  r1;
5'd2: rs2data <=  r2;
5'd3: rs2data <=  r3;
5'd4: rs2data <=  r4;
5'd5: rs2data <=  r5;
5'd6: rs2data <=  r6; 
5'd7: rs2data <=  r7;
5'd8: rs2data <=  r8; 
5'd9: rs2data <=  r9; 
5'd10: rs2data <= r10; 
5'd11: rs2data <= r11; 
5'd12: rs2data <= r12; 
5'd13: rs2data <= r13; 
5'd14: rs2data <= r14; 
5'd15: rs2data <= r15; 
5'd16: rs2data <= r16; 
5'd17: rs2data <= r17; 
5'd18: rs2data <= r18; 
5'd19: rs2data <= r19; 
5'd20: rs2data <= r20; 
5'd21: rs2data <= r21; 
5'd22: rs2data <= r22; 
5'd23: rs2data <= r23;
5'd24: rs2data <= r24; 
5'd25: rs2data <= r25; 
5'd26: rs2data <= r26; 
5'd27: rs2data <= r27; 
5'd28: rs2data <= r28; 
5'd29: rs2data <= r29; 
5'd30: rs2data <= r30; 
5'd31: rs2data <= r31;
endcase
end
    
   
endmodule
