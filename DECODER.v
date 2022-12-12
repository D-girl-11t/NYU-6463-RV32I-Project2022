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
input clk,
input[31:0] instruction,
input decode,
output reg[4:0] ALU_op_d,
output reg[2:0] immsel,
output reg id_comp,
output reg halt, branch,
output reg ALUsrcA, ALUsrcB,
output reg[1:0] WBsel, PCsel,
output reg regwrite, //PCwrite,
output reg memread, memwrite,
output reg[2:0] mem_datatype
);
    
wire[6:0] opcode;
wire[2:0] func3;
wire[2:0] func7;

assign opcode = instruction[6:0];
assign func3 = instruction[14:12];
assign func7 = instruction[31:25];


always@(posedge clk) begin
    if (decode) begin
        id_comp <= 0;
        ALU_op_d <= 0;
        immsel <= 0;
        halt <= 0;
        branch <= 0;
        ALUsrcA <= 0;
        ALUsrcB <= 0;
        WBsel <= 0;
        PCsel <= 0;
        regwrite <= 0;
        //PCwrite <= 0;
        memread <= 0;
        memwrite <= 0;
        mem_datatype <= 0;
        case(opcode)
            7'b0110111: begin
            ALU_op_d <= 5'b00000;//LUI
            immsel <= 3'b000;//imm[31:12]
            ALUsrcB <= 1;//imm
            WBsel <= 2;//alu_out
            regwrite <= 1;
            PCsel <= 0;
            end
            7'b0010111: begin
            ALU_op_d <= 5'b00001;//AUPIC
            immsel <= 3'b000;//imm[31:12]
            ALUsrcA <= 0; //get it from PC
            ALUsrcB <= 1; //imm
            WBsel <= 2;//alu_out
            regwrite <= 1;
            PCsel <= 0;
            end
            7'b1101111: begin 
            ALU_op_d <= 5'b00010;//JAL
            immsel <= 3'b001;//imm[20,10:1,11,19:12]
            ALUsrcA <= 0; //get it from PC
            ALUsrcB <= 1; //imm
            WBsel <= 0;//PC+4
            regwrite <= 1;
            PCsel <= 2;//pc = alu out
            end
            7'b1100111: begin
            ALU_op_d <= 5'b00010;//JALR
            immsel <= 3'b010;//imm[11:0]
            ALUsrcA <= 1; //get it from rs1
            ALUsrcB <= 1; //imm
            WBsel <= 0;//PC+4
            regwrite <= 1;
            PCsel <= 2;//pc = alu out
            end
            7'b1100011: begin
                case(func3)
                    3'b000: begin
                    ALU_op_d <= 5'b00011;//BEQ
                    immsel <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    ALUsrcA <= 1; //get it from rs1
                    ALUsrcB <= 0; //get it from rs2
                    PCsel <= 1;// pc = pc+imm
                    branch <= 1;
                    end
                    3'b001: begin
                    ALU_op_d <= 5'b00100;//BNE
                    immsel <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    ALUsrcA <= 1; //get it from rs1
                    ALUsrcB <= 0; //get it from rs2
                    PCsel <= 1;// pc = pc+imm
                    branch <= 1;
                    end
                    3'b100: begin
                    ALU_op_d <= 5'b00101;//BLT
                    immsel <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    ALUsrcA <= 1; //get it from rs1
                    ALUsrcB <= 0; //get it from rs2
                    PCsel <= 1;// pc = pc+imm
                    branch <= 1;
                    end
                    3'b101: begin
                    ALU_op_d <= 5'b00110;//BGE
                    immsel <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    ALUsrcA <= 1; //get it from rs1
                    ALUsrcB <= 0; //get it from rs2
                    PCsel <= 1;// pc = pc+imm
                    branch <= 1;
                    end
                    3'b110: begin
                    ALU_op_d <= 5'b00111;//BLTU
                    immsel <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    ALUsrcA <= 1; //get it from rs1
                    ALUsrcB <= 0; //get it from rs2
                    PCsel <= 1;// pc = pc+imm
                    branch <= 1;
                    end
                    3'b111: begin
                    ALU_op_d <= 5'b01000;//BGEU
                    immsel <= 3'b011;//imm[12,10:5],imm[4:1,11]
                    ALUsrcA <= 1; //get it from rs1
                    ALUsrcB <= 0; //get it from rs2
                    PCsel <= 1;// pc = pc+imm
                    branch <= 1;
                    end
                    default: ALU_op_d <= 5'b11111; //out of aluop range
                endcase
            end
            7'b0000011: begin
                case(func3)
                    3'b000: begin
                    ALU_op_d <= 5'b00010;//LB
                    immsel <= 3'b010;//imm[11:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;
                    WBsel <= 1;// from DMEM
                    regwrite <= 1;
                    memread <= 1;
                    mem_datatype <= 3'b000;//byte, sign extended 
                    end
                    3'b001: begin
                    ALU_op_d <= 5'b00010;//LH
                    immsel <= 3'b010;//imm[11:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;
                    WBsel <= 1;// from DMEM
                    regwrite <= 1;
                    memread <= 1;
                    mem_datatype <= 3'b001;//half word, sign extended
                    end
                    3'b010: begin
                    ALU_op_d <= 5'b00010;//LW
                    immsel <= 3'b010;//imm[11:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;
                    WBsel <= 1;// from DMEM
                    regwrite <= 1;
                    memread <= 1;
                    mem_datatype <= 3'b010;//word, sign extended
                    end
                    3'b100: begin
                    ALU_op_d <= 5'b00010;//LBU
                    immsel <= 3'b010;//imm[11:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;
                    WBsel <= 1;// from DMEM
                    regwrite <= 1;
                    memread <= 1;
                    mem_datatype <= 3'b011;//byte, zero extended
                    end
                    3'b101: begin
                    ALU_op_d <= 5'b00010;//LHU
                    immsel <= 3'b010;//imm[11:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;
                    WBsel <= 1;// from DMEM
                    regwrite <= 1;
                    memread <= 1;
                    mem_datatype <= 3'b100;//half word, zero extended
                    end
                    default: ALU_op_d <= 5'b11111;
                endcase
            end
            7'b0100011: begin
                case(func3)
                    3'b000: begin
                    ALU_op_d <= 5'b00010;//SB
                    immsel <= 3'b100;//imm[11:5]imm[4:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;
                    memwrite <= 1;
                    mem_datatype <= 3'b000;//SB
                    end
                    3'b001: begin
                    ALU_op_d <= 5'b00010;//SH
                    immsel <= 3'b100;//imm[11:5]imm[4:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;
                    memwrite <= 1;
                    mem_datatype <= 3'b001;//SH
                    end
                    3'b010: begin
                    ALU_op_d <= 5'b00010;//SW, this output is just rs1+imm, the type of rs2 will not be controlled by this module
                    immsel <= 3'b100;//imm[11:5]imm[4:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;
                    memwrite <= 1;
                    mem_datatype <= 3'b010;//SW
                    end
                    default: ALU_op_d <= 5'b11111;
                endcase
            end
            7'b0010011: begin
                case(func3)
                    3'b000: begin
                    ALU_op_d <= 5'b00010;//ADDI
                    immsel <= 3'b010;//imm[11:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;//from imm
                    WBsel <= 2;// from alu out
                    regwrite <= 1;
                    end
                    3'b001: begin
                    ALU_op_d <= 5'b01110;//SLLI
                    immsel <= 3'b010;//imm[11:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;
                    WBsel <= 2;// from alu out
                    regwrite <= 1;
                    end
                    3'b010: begin
                    ALU_op_d <= 5'b01001;//SLTI
                    immsel <= 3'b010;//imm[11:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;
                    WBsel <= 2;// from alu out
                    regwrite <= 1;
                    end
                    3'b011: begin
                    ALU_op_d <= 5'b01010;//SLTIU
                    immsel <= 3'b010;//imm[11:0]
                    ALUsrcA <= 1;//from rs1
                    ALUsrcB <= 1;
                    WBsel <= 2;// from alu out
                    regwrite <= 1;
                    end
                    3'b100: begin
                    ALU_op_d <= 5'b01011;//XORI
                    immsel <= 3'b010;//imm[11:0]
                    ALUsrcA <= 1;
                    ALUsrcB <= 1;
                    WBsel <= 2;// from alu out
                    regwrite <= 1;
                    end
                    3'b101: begin
                    if(func7 == 7'b0100000) begin
                        ALU_op_d <= 5'b10000;//SRAI
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 1;
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    else if(func7 == 0) begin
                        ALU_op_d <= 5'b01111;//SRLI
                        ALUsrcA <= 1;//from rs1 
                        ALUsrcB <= 1;
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    else begin
                        ALU_op_d <= 5'b11111;
                    end
                    end    
                    3'b110: begin
                        ALU_op_d <= 5'b01100;//ORI
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 1;
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    3'b111: begin
                        ALU_op_d <= 5'b01101;//ANDI
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 1;
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                endcase
            end
            7'b0110011: begin
                case(func3)
                    3'b000: begin
                    if(func7 == 0) begin
                        ALU_op_d <= 5'b000010;//ADD
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 0;//from rs2
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    else if(func7 == 7'b0100000) begin
                        ALU_op_d <= 5'b10001;//SUB
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 0;//from rs2
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    else begin
                        ALU_op_d <= 5'b11111;
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 0;//from rs2
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    end
                    3'b001: begin
                        ALU_op_d <= 5'b01110;//SLL
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 0;//from rs2
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    3'b010: begin
                        ALU_op_d <= 5'b01001;//SLT
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 0;//from rs2
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    3'b011: begin
                        ALU_op_d <= 5'b01010;//SLTU
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 0;//from rs2
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    3'b100: begin
                        ALU_op_d <= 5'b01011;//XOR
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 0;//from rs2
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    3'b101: begin
                    if(func7 == 0) begin
                        ALU_op_d <= 5'b01111;//SRL
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 0;//from rs2
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    else if (func7 == 7'b0100000) begin
                        ALU_op_d <= 5'b10000;//SRA
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 0;//from rs2
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end    
                    else
                        ALU_op_d <= 5'b11111;
                    end
                    3'b110: begin
                        ALU_op_d <= 5'b01100;//OR
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 0;//from rs2
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    3'b111: begin
                        ALU_op_d <= 5'b01101;//AND
                        ALUsrcA <= 1;//from rs1
                        ALUsrcB <= 0;//from rs2
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                    end
                    endcase
                end
            7'b0001111: begin
                        ALU_op_d <= 5'b10010;//FENCE, act as ADDI r0, r0, 0
                        immsel <= 3'b111;//out of range so imm will be 0
                        ALUsrcA <= 1;//from rs1, but not important here, because in the ALU, 5b10010 is 0+input2
                        ALUsrcB <= 1;//from imm
                        WBsel <= 2;// from alu out
                        regwrite <= 1;
                        end
            7'b1110011: begin
                        halt <= 1;//ECALL and EBREAK
                        end   
        endcase
        id_comp <= 1;
    end
    else 
        id_comp <= 0;
end    
    
    
    
endmodule
