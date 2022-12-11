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
input clk, memread, memwrite, mem,
input[31:0] addr, wr_data,
input[2:0] data_type,
output reg mem_rd_comp, mem_wr_comp,
output reg[31:0] out_data
    );

parameter DMEMsize = 4096;
wire[31:0] addr_wa;//word addressed 
reg[31:0] DMEM[0:(DMEMsize/4)-1];
reg[31:0] SROM[0:1];// special rom for N number
reg[31:0] N1 = 32'h17192051;
reg[31:0] N2 = 32'h16726992;

initial begin
    $readmemh("dmem.mem", DMEM);
end
/*
initial begin
SROM[0] = N1;
SROM[1] = N2;
DMEM[2] = 32'h00000078;//this is for testing

end
*/
assign addr_wa = (addr[31:0] >> 2)+32'h20000000; //this ram is word addressed, so all the addresses from alu and pc will need to be divided by 4
                                    //this is just to satisfy the 0x800000000 requirement
always@(*) begin
    //if(mem) begin
        //mem_rd_comp <= 0;
        if(memread) begin
            if(addr_wa[31:16] == 16'h2000) begin//0x80000000 = 0x20000000 word addressed, this is to ensure the address begins at 0x80000000
                case(data_type)
                3'b000: out_data <= {{24{DMEM[addr_wa[15:0]][7]}},DMEM[addr_wa[15:0]][7:0]};// read byte, =LB, sign extended
                                                           //the 4096 address will be represented by the lower 16 bits of the address from 0 to 3ffc
                                                           //3ffc is 0011111111111100 so with addr_wa it will become 0000111111111111 = 4095
                3'b001: out_data <= {{16{DMEM[addr_wa[15:0]][15]}},DMEM[addr_wa[15:0]][15:0]};// read half word, =LH, sign extended
                3'b010: out_data <= DMEM[addr_wa[15:0]];// read word, =LW
                3'b011: out_data <= {24'b0,DMEM[addr_wa[15:0]][7:0]};//LBU, zero extended
                3'b100: out_data <= {16'b0,DMEM[addr_wa[15:0]][15:0]};//LHU, zero extended 
                default: out_data <= DMEM[addr_wa[15:0]];
                endcase
                
            end
            else if(addr_wa[31:16] == 16'h0004) begin
                out_data <= SROM[addr_wa[15:0]];
                
            end
            else begin
                out_data <= 0;
                
            end
            /*
            or use 
            else if(addr_wa[31:0] == 32'h00040000)
                out_data <= N1;
            else if(addr_wa[31:0] == 32'h00040001)
                out_data <= N2;
            */
                                                   
        end
        //mem_rd_comp <= 1;
    end
    //else
        //mem_rd_comp <= 0;
//end


always@(posedge clk) begin
    //if(mem) begin
        //mem_wr_comp <= 0;
        if(memwrite) begin
            if(addr_wa[31:16] == 16'h8000) begin
                case(data_type) 
                3'b000: DMEM[addr_wa[15:0]] <= wr_data[7:0];//SB
                3'b001: DMEM[addr_wa[15:0]] <= wr_data[15:0];//SH
                3'b010: DMEM[addr_wa[15:0]] <= wr_data;//SW
                default: DMEM[addr_wa[15:0]] <= wr_data;
                endcase
            end
            //mem_wr_comp <= 1;
        end    
        //else if (memwrite ==0)
            //mem_wr_comp <= 0;
    //end 
end   

/*
reg[7:0] DMEM0[0:(DMEMsize/4)-1];  
reg[7:0] DMEM1[0:(DMEMsize/4)-1];  
reg[7:0] DMEM2[0:(DMEMsize/4)-1];  
reg[7:0] DMEM3[0:(DMEMsize/4)-1];

always@(*) begin
if(instrfetch) begin
    if(addr_imem[31:12] == 20'b0000_0001_0000_0000_0000)
        instr = {IMEM0[addr_imem[11:0]>>2],IMEM1[addr_imem[11:0]>>2],IMEM2[addr_imem[11:0]>>2],IMEM3[addr_imem[11:0]>>2]};// this is big endian  
end
end

    
always@(posedge clk) begin
    if(mem) begin
            if(memread) begin
                if(addr_wa[31:16] == 16'h2000)//0x80000000 = 0x20000000 word addressed, this is to ensure the address begins at 0x80000000
                    case(data_type)// instruction memory begins at 0x01000000
            IMEM0[addr_imem[11:0]>>2] = rom_words[addr_imem[11:0]>>2][31:24];
            IMEM1[addr_imem[11:0]>>2] = rom_words[addr_imem[11:0]>>2][23:16];
            IMEM2[addr_imem[11:0]>>2] = rom_words[addr_imem[11:0]>>2][15:8];
            IMEM3[addr_imem[11:0]>>2] = rom_words[addr_imem[11:0]>>2][7:0];  //address incremented by 4 and we only have 512 addresses, so the addresses needs to be divided by 4  
        end
        else 
            instr = 32'h0;    
    end
    else 
    instrf_update = 1'b0;
end
*/

endmodule
