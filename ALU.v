`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2022 02:26:50 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:no copilot
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input[4:0] ALU_op,
    input[31:0] input1,
    input[31:0] input2, 
    output reg[31:0] alu_out,
    output reg zero
    );
    
    
    
reg[31:0] temp = 32'b0;
always@(*) begin
    case(ALU_op)
    5'b00000: alu_out = {input2, 12'b0}; //LUI
    5'b00001: alu_out = input1+{input2, 12'b0};// AUPIC
    5'b00010: alu_out = input1+input2;//JAL,JALR,LW,SB,SH,SW,ADD,ADDI
    5'b00011: zero = (input1 == input2)?1 : 0;//BEQ
    5'b00100: zero = (input1 == input2)?0 : 1;//BNE
    5'b000101: zero = (input1 < input2)?1:0;//BLT BLTU
    5'b00110: zero = (input1 >= input2)?1:0;//BGE BGEU
    5'b00111: begin //LB
    temp = input1+input2;
    alu_out[31:8] = {24{temp[7]}};
    alu_out[7:0] = temp[7:0];
    end  
    5'b01000: begin //LH
    temp = input1+input2;
    alu_out[31:16] = {24{temp[15]}};
    alu_out[15:0] = temp[15:0];
    end
    5'b01001: begin //LBU
    temp = input1+input2;
    alu_out = {25'b00,temp[7:0]};
    end
    5'b01010: begin //LHU
    temp = input1+input2;
    alu_out = {16'b0,temp[15:0]};
    end
    5'b01011: alu_out = (input1 < input2)? 1:0; //SLTI,SLTIU,SLT,SLTU
    5'b01100: alu_out = input1 ^ input2; //XORI,XOR
    5'b01101: alu_out = input1 | input2; //ORI,OR
    5'b01110: alu_out = input1 & input2; //ANDI,AND
    5'b01111: alu_out = (input2[4:0] == 5'b00001)?{input1[30:0],1'b0}: //SLLI, SLL
                   (input2[4:0] == 5'b00010)?{input1[29:0],2'b0}:
                   (input2[4:0] == 5'b00011)?{input1[28:0],3'b0}:
                   (input2[4:0] == 5'b00100)?{input1[27:0],4'b0}: 
	               (input2[4:0] == 5'b00101)?{input1[26:0],5'b0}:
	               (input2[4:0] == 5'b00110)?{input1[25:0],6'b0}:
	               (input2[4:0] == 5'b00111)?{input1[24:0],7'b0}:
	               (input2[4:0] == 5'b01000)?{input1[23:0],8'b0}:
	               (input2[4:0] == 5'b01001)?{input1[22:0],9'b0}:
	               (input2[4:0] == 5'b01010)?{input1[21:0],10'b0}:
	               (input2[4:0] == 5'b01011)?{input1[20:0],11'b0}:
	               (input2[4:0] == 5'b01100)?{input1[19:0],12'b0}:
	               (input2[4:0] == 5'b01101)?{input1[18:0],13'b0}:
                   (input2[4:0] == 5'b01110)?{input1[17:0],14'b0}:
	               (input2[4:0] == 5'b01111)?{input1[16:0],15'b0}:
	               (input2[4:0] == 5'b10000)?{input1[15:0],16'b0}:
	               (input2[4:0] == 5'b10001)?{input1[14:0],17'b0}:
	               (input2[4:0] == 5'b10010)?{input1[13:0],18'b0}:
	               (input2[4:0] == 5'b10011)?{input1[12:0],19'b0}:
	               (input2[4:0] == 5'b10100)?{input1[11:0],20'b0}:
	               (input2[4:0] == 5'b10101)?{input1[10:0],21'b0}:
	               (input2[4:0] == 5'b10110)?{input1[09:0],22'b0}:
	               (input2[4:0] == 5'b10111)?{input1[08:0],23'b0}:
	               (input2[4:0] == 5'b11000)?{input1[07:0],24'b0}:
	               (input2[4:0] == 5'b11001)?{input1[06:0],25'b0}:
	               (input2[4:0] == 5'b11010)?{input1[05:0],26'b0}:
	               (input2[4:0] == 5'b11011)?{input1[04:0],27'b0}:
	               (input2[4:0] == 5'b11100)?{input1[03:0],28'b0}:
	               (input2[4:0] == 5'b11101)?{input1[02:0],29'b0}:
	               (input2[4:0] == 5'b11110)?{input1[01:0],30'b0}:
	               (input2[4:0] == 5'b11111)?{input1[0],31'b0}:
	               input1;
	               
	5'b10000: alu_out = (input2[4:0] == 5'b00001)?{1'b0,input1[31:5'b00001]}: //SRLI,SRL
                   (input2[4:0] == 5'b00010)?{2'b0,input1[31:5'b00010]}: 
                   (input2[4:0] == 5'b00011)?{3'b0,input1[31:5'b00011]}:
                   (input2[4:0] == 5'b00100)?{4'b0,input1[31:5'b00100]}: 
	               (input2[4:0] == 5'b00101)?{5'b0,input1[31:5'b00101]}:
	               (input2[4:0] == 5'b00110)?{6'b0,input1[31:5'b00110]}:
	               (input2[4:0] == 5'b00111)?{7'b0,input1[31:5'b00111]}:
	               (input2[4:0] == 5'b01000)?{8'b0,input1[31:5'b01000]}:
	               (input2[4:0] == 5'b01001)?{9'b0,input1[31:5'b01001]}:
	               (input2[4:0] == 5'b01010)?{10'b0,input1[31:5'b01010]}:
	               (input2[4:0] == 5'b01011)?{11'b0,input1[31:5'b01011]}:
	               (input2[4:0] == 5'b01100)?{12'b0,input1[31:5'b01100]}:
	               (input2[4:0] == 5'b01101)?{13'b0,input1[31:5'b01101]}:
                   (input2[4:0] == 5'b01110)?{14'b0,input1[31:5'b01110]}:
	               (input2[4:0] == 5'b01111)?{15'b0,input1[31:5'b01111]}:
	               (input2[4:0] == 5'b10000)?{16'b0,input1[31:5'b10000]}:
	               (input2[4:0] == 5'b10001)?{17'b0,input1[31:5'b10001]}:
	               (input2[4:0] == 5'b10010)?{18'b0,input1[31:5'b10010]}:
	               (input2[4:0] == 5'b10011)?{19'b0,input1[31:5'b10011]}:
	               (input2[4:0] == 5'b10100)?{20'b0,input1[31:5'b10100]}:
	               (input2[4:0] == 5'b10101)?{21'b0,input1[31:5'b10101]}:
	               (input2[4:0] == 5'b10110)?{22'b0,input1[31:5'b10110]}:
	               (input2[4:0] == 5'b10111)?{23'b0,input1[31:5'b10111]}:
	               (input2[4:0] == 5'b11000)?{24'b0,input1[31:5'b11000]}:
	               (input2[4:0] == 5'b11001)?{25'b0,input1[31:5'b11001]}:
	               (input2[4:0] == 5'b11010)?{26'b0,input1[31:5'b11010]}:
	               (input2[4:0] == 5'b11011)?{27'b0,input1[31:5'b11011]}:
	               (input2[4:0] == 5'b11100)?{28'b0,input1[31:5'b11100]}:
	               (input2[4:0] == 5'b11101)?{29'b0,input1[31:5'b11101]}:
	               (input2[4:0] == 5'b11110)?{30'b0,input1[31:5'b11110]}:
	               (input2[4:0] == 5'b11111)?{31'b0,input1[31:5'b11111]}:
	               input1;
	5'b10001: alu_out = (input2[4:0] == 5'b00001)?{input1[31],input1[31:5'b00001]}: //SRAI,SRA
                   (input2[4:0] == 5'b00010)?{{2{input1[31]}},input1[31:5'b00010]}: 
                   (input2[4:0] == 5'b00011)?{{3{input1[31]}},input1[31:5'b00011]}:
                   (input2[4:0] == 5'b00100)?{{4{input1[31]}},input1[31:5'b00100]}: 
	               (input2[4:0] == 5'b00101)?{{5{input1[31]}},input1[31:5'b00101]}:
	               (input2[4:0] == 5'b00110)?{{6{input1[31]}},input1[31:5'b00110]}:
	               (input2[4:0] == 5'b00111)?{{7{input1[31]}},input1[31:5'b00111]}:
	               (input2[4:0] == 5'b01000)?{{8{input1[31]}},input1[31:5'b01000]}:
	               (input2[4:0] == 5'b01001)?{{9{input1[31]}},input1[31:5'b01001]}:
	               (input2[4:0] == 5'b01010)?{{10{input1[31]}},input1[31:5'b01010]}:
	               (input2[4:0] == 5'b01011)?{{11{input1[31]}},input1[31:5'b01011]}:
	               (input2[4:0] == 5'b01100)?{{12{input1[31]}},input1[31:5'b01100]}:
	               (input2[4:0] == 5'b01101)?{{13{input1[31]}},input1[31:5'b01101]}:
                   (input2[4:0] == 5'b01110)?{{14{input1[31]}},input1[31:5'b01110]}:
	               (input2[4:0] == 5'b01111)?{{15{input1[31]}},input1[31:5'b01111]}:
	               (input2[4:0] == 5'b10000)?{{16{input1[31]}},input1[31:5'b10000]}:
	               (input2[4:0] == 5'b10001)?{{17{input1[31]}},input1[31:5'b10001]}:
	               (input2[4:0] == 5'b10010)?{{18{input1[31]}},input1[31:5'b10010]}:
	               (input2[4:0] == 5'b10011)?{{19{input1[31]}},input1[31:5'b10011]}:
	               (input2[4:0] == 5'b10100)?{{20{input1[31]}},input1[31:5'b10100]}:
	               (input2[4:0] == 5'b10101)?{{21{input1[31]}},input1[31:5'b10101]}:
	               (input2[4:0] == 5'b10110)?{{22{input1[31]}},input1[31:5'b10110]}:
	               (input2[4:0] == 5'b10111)?{{23{input1[31]}},input1[31:5'b10111]}:
	               (input2[4:0] == 5'b11000)?{{24{input1[31]}},input1[31:5'b11000]}:
	               (input2[4:0] == 5'b11001)?{{25{input1[31]}},input1[31:5'b11001]}:
	               (input2[4:0] == 5'b11010)?{{26{input1[31]}},input1[31:5'b11010]}:
	               (input2[4:0] == 5'b11011)?{{27{input1[31]}},input1[31:5'b11011]}:
	               (input2[4:0] == 5'b11100)?{{28{input1[31]}},input1[31:5'b11100]}:
	               (input2[4:0] == 5'b11101)?{{29{input1[31]}},input1[31:5'b11101]}:
	               (input2[4:0] == 5'b11110)?{{30{input1[31]}},input1[31:5'b11110]}:
	               (input2[4:0] == 5'b11111)?{{31{input1[31]}},input1[31:5'b11111]}:
	               input1; 
	5'b10010: alu_out =  input1 - input2; //SUB
    default: begin
             zero = 0;
             alu_out = 32'h0;
             end
	endcase       
end
    
    
    
    
    
    
    
    
    
        
endmodule