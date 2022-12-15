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
input[3:0] byte_enable,
input[31:0] addr, wr_data,
//input[1:0] data_type,
input[15:0] switch,
output reg[31:0] out_data
    );

parameter DMEMsize = 4096;
wire[31:0] addr_wa;//word addressed 
//reg[31:0] DMEM[0:(DMEMsize/4)+3];
reg[7:0] DMEM0[0:(DMEMsize/4)-1];
reg[7:0] DMEM1[0:(DMEMsize/4)-1];
reg[7:0] DMEM2[0:(DMEMsize/4)-1];
reg[7:0] DMEM3[0:(DMEMsize/4)-1];
//reg[31:0] SMEM[0:5];// special mem for N number, switches and LED
reg[31:0] N1 = 32'h17192051;
reg[31:0] N2 = 32'h16726992;
reg[15:0] LED;
//reg[31:0] DMEM [0:(DMEMsize/4)]; 

/*
initial begin
    $readmemh("odd_dmem.mem", DMEM);
end
*/



assign addr_wa = (addr[31:0] >> 2); //+ 32'h20000000; //this ram is word addressed, so all the addresses from alu and pc will need to be divided by 4
/*
always@(reset)begin
if (reset) begin
    DMEM0[addr_wa[9:0]] <= DMEM[addr_wa[9:0]][31:24];
    DMEM1[addr_wa[9:0]] <= DMEM[addr_wa[9:0]][23:16];
    DMEM2[addr_wa[9:0]] <= DMEM[addr_wa[9:0]][15:8];
    DMEM3[addr_wa[9:0]] <= DMEM[addr_wa[9:0]][7:0];
end
else begin
    DMEM0[addr_wa[9:0]] <= DMEM0[addr_wa[9:0]];
    DMEM1[addr_wa[9:0]] <= DMEM1[addr_wa[9:0]];
    DMEM2[addr_wa[9:0]] <= DMEM2[addr_wa[9:0]];
    DMEM3[addr_wa[9:0]] <= DMEM3[addr_wa[9:0]];
end       
end
*/
/*                                    //this is just to satisfy the 0x800000000 requirement
always@(*) begin
    if(memread) begin
        if(addr_wa[31:16] == 16'h2000) begin//0x80000000 = 0x20000000 word addressed, this is to ensure the address begins at 0x80000000
            case(data_type)
            3'b000: out_data <= {{24{DMEM[addr_wa[9:0]][7]}},DMEM[addr_wa[9:0]][7:0]};// read byte, =LB, sign extended
                                                       //the 4096 address will be represented by the lower 16 bits of the address from 0 to 3ffc
                                                       //3ffc is 0011111111111100 so with addr_wa it will become 0000111111111111 = 4095
            3'b001: out_data <= {{16{DMEM[addr_wa[9:0]][15]}},DMEM[addr_wa[9:0]][15:0]};// read half word, =LH, sign extended
            3'b010: out_data <= DMEM[addr_wa[9:0]];// read word, =LW
            3'b011: out_data <= {24'b0,DMEM[addr_wa[9:0]][7:0]};//LBU, zero extended
            3'b100: out_data <= {16'b0,DMEM[addr_wa[9:0]][15:0]};//LHU, zero extended 
            default: out_data <= 0;
            endcase  
        end
        else begin
            if(addr[31:0] == 32'h00100000)
                out_data <= DMEM[1024];
            else if(addr[31:0] == 32'h00100004)
                out_data <= DMEM[1025];
            else if(addr[31:0] == 32'h00100010)
                out_data <= {16'b0,switch};
            else if(addr[31:0] == 32'h00100014) 
                out_data <= {16'b0,DMEM[1027]};
            else
                out_data <= 0;  
        end        
    end
    else
        out_data <= {16'b0,DMEM[(DMEMsize/4)+3]};
end
*/
/*
always@(*)begin
    case(data_type)
        3'b000: lsudata <= {{24{DMEM[addr_wa[9:0]][7]}},DMEM[addr_wa[9:0]][7:0]};// read byte, =LB, sign extended
                                                   //the 4096 address will be represented by the lower 16 bits of the address from 0 to 3ffc
                                                   //3ffc is 0011111111111100 so with addr_wa it will become 0000111111111111 = 4095
        3'b001: lsudata <= {{16{DMEM[addr_wa[9:0]][15]}},DMEM[addr_wa[9:0]][15:0]};// read half word, =LH, sign extended
        3'b010: lsudata <= DMEM[addr_wa[9:0]];// read word, =LW
        3'b011: lsudata <= {24'b0,DMEM[addr_wa[9:0]][7:0]};//LBU, zero extended
        3'b100: lsudata <= {16'b0,DMEM[addr_wa[9:0]][15:0]};//LHU, zero extended 
        default: lsudata <= 0;
    endcase
end
*/
always@(*) begin
    if(memread) begin
        if(addr[31:0] == 32'h00100000)
            out_data <= N1;
        else if(addr[31:0] == 32'h00100004)
            out_data <= N2;
        else if(addr[31:0] == 32'h00100010)
            out_data <= {16'b0,switch};
        else if(addr[31:0] == 32'h00100014) 
            out_data <= {16'b0,LED};
        else 
            out_data <= {DMEM0[addr_wa[9:0]], DMEM1[addr_wa[9:0]], DMEM2[addr_wa[9:0]], DMEM3[addr_wa[9:0]]};  
    end
    else
        out_data <= {16'b0,LED};
        //out_data <= 0;
end




    
always@(posedge clk) begin
    if(memwrite) begin
        if(addr_wa[31:16] == 16'h2000) begin
            if(byte_enable[0])
                DMEM0[addr_wa[9:0]] <= wr_data[07:00];
            if(byte_enable[1])
                DMEM1[addr_wa[9:0]] <= wr_data[15:08];
            if(byte_enable[2])
                DMEM2[addr_wa[9:0]] <= wr_data[23:16];
            if(byte_enable[3])
                DMEM3[addr_wa[9:0]] <= wr_data[31:24];     
        end
        else if(addr[31:0] == 32'h00100014)
            LED <= {16'b0,wr_data[15:0]};
        //else 
                
    end 
         
end   

endmodule
