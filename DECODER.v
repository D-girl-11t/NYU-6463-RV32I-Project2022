`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2022 05:47:32 PM
// Design Name: 
// Module Name: DECODER
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


module DECODER(
input[31:0] instruction,
output reg[4:0] ALU_op_d,
output reg[2:0] immsel,
output reg halt
);
    
wire[5:0] opcode;
wire[2:0] func3;
wire[2:0] func7;

assign opcode = instruction[6:0];
assign func3 = instruction[14:12];
assign func7 = instruction[31:25];


always@(*) begin
case(opcode)
    7'b0110111: begin
    ALU_op_d = 5'b00000;//LUI
    immsel = 3'b000;//imm[31:12]
    end
    7'b0010111: begin
    ALU_op_d = 5'b00001;//AUPIC
    immsel = 3'b000;//imm[31:12]
    end
    7'b1101111: begin 
    ALU_op_d = 5'b00010;//JAL
    immsel = 3'b001;//imm[20,10:1,11,19:12]
    end
    7'b1100111: begin
    ALU_op_d = 5'b00010;//JALR
    immsel = 3'b010;//imm[11:0]
    end
    7'b1100011: begin
    case(func3)
        3'b000: begin
        ALU_op_d = 5'b00011;//BEQ
        immsel = 3'b011;//imm[12,10:5],imm[4:1,11]
        end
        3'b001: begin
        ALU_op_d = 5'b00100;//BNE
        immsel = 3'b011;//imm[12,10:5],imm[4:1,11]
        end
        3'b100: begin
        ALU_op_d = 5'b00101;//BLT
        immsel = 3'b011;//imm[12,10:5],imm[4:1,11]
        end
        3'b101: begin
        ALU_op_d = 5'b00110;//BGE
        immsel = 3'b011;//imm[12,10:5],imm[4:1,11]
        end
        3'b110: begin
        ALU_op_d = 5'b00111;//BLTU
        immsel = 3'b011;//imm[12,10:5],imm[4:1,11]
        end
        3'b111: begin
        ALU_op_d = 5'b01000;//BGEU
        immsel = 3'b011;//imm[12,10:5],imm[4:1,11]
        end
        default: ALU_op_d = 5'b11111; //out of aluop range
    endcase
    end
    7'b0000011: begin
    case(func3)
        3'b000: begin
        ALU_op_d = 5'b00010;//LB
        immsel = 3'b010;//imm[11:0]
        end
        3'b001: begin
        ALU_op_d = 5'b00010;//LH
        immsel = 3'b010;//imm[11:0]
        end
        3'b010: begin
        ALU_op_d = 5'b00010;//LW
        immsel = 3'b010;//imm[11:0]
        end
        3'b100: begin
        ALU_op_d = 5'b00010;//LBU
        immsel = 3'b010;//imm[11:0]
        end
        3'b101: begin
        ALU_op_d = 5'b00010;//LHU
        immsel = 3'b010;//imm[11:0]
        end
        default: ALU_op_d = 5'b11111;
    endcase
    end
    7'b01000111: begin
    case(func3)
        3'b000: begin
        ALU_op_d = 5'b00010;//SB
        immsel = 3'b100;//imm[11:5]imm[4:0]
        end
        3'b001: begin
        ALU_op_d = 5'b00010;//SH
        immsel = 3'b100;//imm[11:5]imm[4:0]
        end
        3'b010: begin
        ALU_op_d = 5'b00010;//SW, this output is just rs1+imm, the type of rs2 will not be controlled by this module
        immsel = 3'b100;//imm[11:5]imm[4:0]
        end
        default: ALU_op_d = 5'b11111;
    endcase
    end
    7'b0010011: begin
    case(func3)
        3'b000: begin
        ALU_op_d = 5'b00010;//ADDI
        immsel = 3'b010;//imm[11:0]
        end
        3'b001: begin
        ALU_op_d = 5'b01110;//SLLI
        immsel = 3'b010;//imm[11:0]
        end
        3'b010: begin
        ALU_op_d = 5'b01001;//SLTI
        immsel = 3'b010;//imm[11:0]
        end
        3'b011: begin
        ALU_op_d = 5'b01010;//SLTIU
        immsel = 3'b010;//imm[11:0]
        end
        3'b100: begin
        ALU_op_d = 5'b01011;//XORI
        immsel = 3'b010;//imm[11:0]
        end
        3'b101: begin
        if(func7 == 7'b0100000)
            ALU_op_d = 5'b10000;//SRAI
        else if(func7 == 0)
            ALU_op_d = 5'b01111;//SRLI
        else
            ALU_op_d = 5'b11111;
        end    
        3'b110: ALU_op_d = 5'b01100;//ORI
        3'b111: ALU_op_d = 5'b01101;//ANDI
    endcase
    end
    7'b0110011: begin
    case(func3)
        3'b000: begin
        if(func7 == 0)
            ALU_op_d = 5'b000010;//ADD
        else if(func7 == 7'b0100000)
            ALU_op_d = 5'b10001;//SUB
        else 
            ALU_op_d = 5'b11111;
        end
        3'b001: ALU_op_d = 5'b01110;//SLL
        3'b010: ALU_op_d = 5'b01001;//SLT
        3'b011: ALU_op_d = 5'b01010;//SLTU
        3'b100: ALU_op_d = 5'b01011;//XOR
        3'b101: begin
        if(func7 == 0)
            ALU_op_d = 5'b01111;//SRL
        else if (func7 == 7'b0100000)
            ALU_op_d = 5'b10000;//SRA
        else
            ALU_op_d = 5'b11111;
        end
        3'b110: ALU_op_d = 5'b01100;//OR
        3'b111: ALU_op_d = 5'b01101;//AND
        endcase
        end
    7'b0001111: begin
                ALU_op_d = 5'b10010;//FENCE, act as ADDI r0, r0, 0
                immsel = 3'b010;
                end
    7'b1110011: halt = 1;//ECALL and EBREAK   
    endcase
end    
    
    
    
endmodule
