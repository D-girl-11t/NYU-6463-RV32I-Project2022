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
    5'b00000: alu_out <= {input2[31:12], 12'b0}; //LUI
    5'b00001: alu_out <= input1+{input2[31:12], 12'b0};// AUPIC
    5'b00010: alu_out <= input1+input2;//JAL,JALR,LB,LH,LBU,LHU,LW,SB,SH,SW,ADD,ADDI
    5'b00011: zero <= (input1 == input2)?1 : 0;//BEQ
    5'b00100: zero <= (input1 == input2)?0 : 1;//BNE
    5'b00101: zero <= ($signed(input1) < $signed(input2))?1 : 0;//BLT 
    5'b00110: zero <= ($signed(input1) >= $signed(input2))?1 : 0;//BGE 
    5'b00111: zero <= (input1 < input2)?1 : 0;//BLTU
    5'b01000: zero <= (input1 >= input2)?1 : 0;//BGEU
    5'b01001: alu_out <= ($signed(input1) < $signed(input2))?1 : 0; //SLTI,SLT
    5'b01010: alu_out <= (input1 < input2)?1 : 0;//SLTIU,SLTU
    5'b01011: alu_out <= input1 ^ input2; //XORI,XOR
    5'b01100: alu_out <= input1 | input2; //ORI,OR
    5'b01101: alu_out <= input1 & input2; //ANDI,AND
    5'b01110: begin //SLLI, SLL
    case(input2[4:0])
       5'b00000: alu_out <= input1;
       5'b00001: alu_out <= {input1[30:0],1'b0};
       5'b00010: alu_out <= {input1[29:0],2'b0}; 
       5'b00011: alu_out <= {input1[28:0],3'b0};
       5'b00100: alu_out <= {input1[27:0],4'b0};
       5'b00101: alu_out <= {input1[26:0],5'b0};
       5'b00110: alu_out <= {input1[25:0],6'b0};
       5'b00111: alu_out <= {input1[24:0],7'b0};
       5'b01000: alu_out <= {input1[23:0],8'b0};
       5'b01001: alu_out <= {input1[22:0],9'b0};
       5'b01010: alu_out <= {input1[21:0],10'b0};
       5'b01011: alu_out <= {input1[20:0],11'b0};
       5'b01100: alu_out <= {input1[19:0],12'b0};
       5'b01101: alu_out <= {input1[18:0],13'b0};
       5'b01110: alu_out <= {input1[17:0],14'b0};
       5'b01111: alu_out <= {input1[16:0],15'b0};
       5'b10000: alu_out <= {input1[15:0],16'b0};
       5'b10001: alu_out <= {input1[14:0],17'b0};
       5'b10010: alu_out <= {input1[13:0],18'b0};
       5'b10011: alu_out <= {input1[12:0],19'b0};
       5'b10100: alu_out <= {input1[11:0],20'b0};
       5'b10101: alu_out <= {input1[10:0],21'b0};
       5'b10110: alu_out <= {input1[09:0],22'b0};
       5'b10111: alu_out <= {input1[08:0],23'b0};
       5'b11000: alu_out <= {input1[07:0],24'b0};
       5'b11001: alu_out <= {input1[06:0],25'b0};
       5'b11010: alu_out <= {input1[05:0],26'b0};
       5'b11011: alu_out <= {input1[04:0],27'b0};
       5'b11100: alu_out <= {input1[03:0],28'b0};
       5'b11101: alu_out <= {input1[02:0],29'b0};
       5'b11110: alu_out <= {input1[01:0],30'b0};
       5'b11111: alu_out <= {input1[0],31'b0};
    endcase
    end
            
    5'b01111: begin //SRLI,SRL
    case(input2[4:0])
       5'b00000: alu_out <= input1;
       5'b00001: alu_out <= {1'b0,input1[31:5'b00001]};
       5'b00010: alu_out <= {2'b0,input1[31:5'b00010]};
       5'b00011: alu_out <= {3'b0,input1[31:5'b00011]};
       5'b00100: alu_out <= {4'b0,input1[31:5'b00100]}; 
       5'b00101: alu_out <= {5'b0,input1[31:5'b00101]};
       5'b00110: alu_out <= {6'b0,input1[31:5'b00110]};
       5'b00111: alu_out <= {7'b0,input1[31:5'b00111]};
       5'b01000: alu_out <= {8'b0,input1[31:5'b01000]};
       5'b01001: alu_out <= {9'b0,input1[31:5'b01001]};
       5'b01010: alu_out <= {10'b0,input1[31:5'b01010]};
       5'b01011: alu_out <= {11'b0,input1[31:5'b01011]};
       5'b01100: alu_out <= {12'b0,input1[31:5'b01100]};
       5'b01101: alu_out <= {13'b0,input1[31:5'b01101]};
       5'b01110: alu_out <= {14'b0,input1[31:5'b01110]};
       5'b01111: alu_out <= {15'b0,input1[31:5'b01111]};
       5'b10000: alu_out <= {16'b0,input1[31:5'b10000]};
       5'b10001: alu_out <= {17'b0,input1[31:5'b10001]};
       5'b10010: alu_out <= {18'b0,input1[31:5'b10010]};
       5'b10011: alu_out <= {19'b0,input1[31:5'b10011]};
       5'b10100: alu_out <= {20'b0,input1[31:5'b10100]};
       5'b10101: alu_out <= {21'b0,input1[31:5'b10101]};
       5'b10110: alu_out <= {22'b0,input1[31:5'b10110]};
       5'b10111: alu_out <= {23'b0,input1[31:5'b10111]};
       5'b11000: alu_out <= {24'b0,input1[31:5'b11000]};
       5'b11001: alu_out <= {25'b0,input1[31:5'b11001]};
       5'b11010: alu_out <= {26'b0,input1[31:5'b11010]};
       5'b11011: alu_out <= {27'b0,input1[31:5'b11011]};
       5'b11100: alu_out <= {28'b0,input1[31:5'b11100]};
       5'b11101: alu_out <= {29'b0,input1[31:5'b11101]};
       5'b11110: alu_out <= {30'b0,input1[31:5'b11110]};
       5'b11111: alu_out <= {31'b0,input1[31:5'b11111]};
    endcase
    end
    
    5'b10000: begin //SRAI,SRA
    case(input2[4:0])
       5'b00000: alu_out <= input1;
       5'b00001: alu_out <= {input1[31],input1[31:5'b00001]}; 
       5'b00010: alu_out <= {{2{input1[31]}},input1[31:5'b00010]};
       5'b00011: alu_out <= {{3{input1[31]}},input1[31:5'b00011]};
       5'b00100: alu_out <= {{4{input1[31]}},input1[31:5'b00100]};
       5'b00101: alu_out <= {{5{input1[31]}},input1[31:5'b00101]};
       5'b00110: alu_out <= {{6{input1[31]}},input1[31:5'b00110]};
       5'b00111: alu_out <= {{7{input1[31]}},input1[31:5'b00111]};
       5'b01000: alu_out <= {{8{input1[31]}},input1[31:5'b01000]};
       5'b01001: alu_out <= {{9{input1[31]}},input1[31:5'b01001]};
       5'b01010: alu_out <= {{10{input1[31]}},input1[31:5'b01010]};
       5'b01011: alu_out <= {{11{input1[31]}},input1[31:5'b01011]};
       5'b01100: alu_out <= {{12{input1[31]}},input1[31:5'b01100]};
       5'b01101: alu_out <= {{13{input1[31]}},input1[31:5'b01101]};
       5'b01110: alu_out <= {{14{input1[31]}},input1[31:5'b01110]};
       5'b01111: alu_out <= {{15{input1[31]}},input1[31:5'b01111]};
       5'b10000: alu_out <= {{16{input1[31]}},input1[31:5'b10000]};
       5'b10001: alu_out <= {{17{input1[31]}},input1[31:5'b10001]};
       5'b10010: alu_out <= {{18{input1[31]}},input1[31:5'b10010]};
       5'b10011: alu_out <= {{19{input1[31]}},input1[31:5'b10011]};
       5'b10100: alu_out <= {{20{input1[31]}},input1[31:5'b10100]};
       5'b10101: alu_out <= {{21{input1[31]}},input1[31:5'b10101]};
       5'b10110: alu_out <= {{22{input1[31]}},input1[31:5'b10110]};
       5'b10111: alu_out <= {{23{input1[31]}},input1[31:5'b10111]};
       5'b11000: alu_out <= {{24{input1[31]}},input1[31:5'b11000]};
       5'b11001: alu_out <= {{25{input1[31]}},input1[31:5'b11001]};
       5'b11010: alu_out <= {{26{input1[31]}},input1[31:5'b11010]};
       5'b11011: alu_out <= {{27{input1[31]}},input1[31:5'b11011]};
       5'b11100: alu_out <= {{28{input1[31]}},input1[31:5'b11100]};
       5'b11101: alu_out <= {{29{input1[31]}},input1[31:5'b11101]};
       5'b11110: alu_out <= {{30{input1[31]}},input1[31:5'b11110]};
       5'b11111: alu_out <= {{31{input1[31]}},input1[31:5'b11111]};
    endcase
    end
                   
    5'b10001: alu_out <=  input1 - input2; //SUB
    5'b10010: alu_out <= 0 + input2;
    5'b10011: alu_out <= input1 + input2 - 32'h01000000;//JAL,JALR
    default: begin
             zero <= 0;
             alu_out <= 32'h0;
             end
    endcase
     
end
  
        
endmodule
