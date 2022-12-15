`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/10/2022 01:48:05 PM
// Design Name: 
// Module Name: Processor
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


module Processor(
input wire CLK100MHZ,
input wire btnC,
input wire[15:0] sw,
//output wire seg,
//output wire[15:0] memread_data,
//output wire[15:0] memwrite_data,
//output wire[15:0] mem_out
output wire[15:0] LED
    );
  
//--------------PC--------------------
//wire clk, 
wire PCwrite, pc_update;
wire[31:0] new_count, addr;
//------------------------------------

//--------------IMEM------------------
wire instrfetch, instr_fetched;
wire[31:0] instr;// output instruction
//------------------------------------

//--------------DECODER---------------
wire decode, id_comp, branch, halt, ALUsrcA, ALUsrcB, regwrite, memread, memwrite;
wire sign_extend;
wire[1:0] WBsel, PCsel, mem_datatype;
wire[2:0] immsel; 
wire[4:0] alu_op_d;
//------------------------------------

//--------------REG-------------------
wire wb, wb_comp;
wire[31:0] rs1data, rs2data, wrdata;
//------------------------------------

//--------------IMMGEN----------------
wire[31:0] immgen_out;
//------------------------------------

//--------------ALU-------------------
wire zero;
wire[31:0] rs1data_mux, rs2data_mux, alu_out;
//------------------------------------

//--------------DMEM------------------
//wire mem, mem_rd_comp, mem_wr_comp;
wire[31:0] wr_data, LSU_wr_data; //out_data;// output instruction
wire[3:0] byte_enable;
wire[31:0] LSU_rs2;
//wire[31:0] result;
//------------------------------------

//--------------ADD4------------------
wire[31:0] PC4;
//------------------------------------

//--------------PCSUM-----------------
wire[31:0] PCSUM;
//------------------------------------

//--------------MUXBRANCHPC-----------
wire[31:0] branchpc;
//------------------------------------

//--------------SUBPC-----------------
wire[31:0] JAL_store;
//------------------------------------



Control_Unit CU(
.clk(CLK100MHZ),                       
.pc_update(pc_update),//from PC                 
.instr_fetched(instr_fetched),//from IF             
.memwrite(memwrite),//from DECODER 
.memread(memread),//from DECODER         
.id_comp(id_comp),//from DECODER
.regwrite(regwrite),//from DECODER
.halt(halt),//from DECODER
.branch(branch),//from DECODER 
//.mem_rd_comp(mem_rd_comp),//from DMEM
//.mem_wr_comp(mem_wr_comp),//from DMEM
.wb_comp(wb_comp),//from REG
.alu_op_d(alu_op_d),//from DECODER               
.decode(decode),//to DECODER               
.PCwrite(PCwrite),//to PC              
.instrfetch(instrfetch),//to IMEM
//.mem(mem),//to DMEM
.wb(wb)//to REG   
);

programcounter PC(
.clk(CLK100MHZ),
.PCwrite(PCwrite),//from control unit
.rst(btnC),
.new_count(new_count),
.addr(addr),//to IMEM, muxsrcA, PCSUM, ADD4
.pc_update(pc_update)
);

IMEM IMEM(
.clk(CLK100MHZ),
.instrfetch(instrfetch),//from control unit
.addr_imem(addr),//from pc
.instr(instr),//to DECODER, REG, and IMMGEN
.instr_fetched(instr_fetched)
);

DECODER DECODER(
.clk(CLK100MHZ),
.decode(decode),//from control unit
.instruction(instr),//from IMEM
.id_comp(id_comp),//to control unit
.sign_extend(sign_extend),//to LSU
.branch(branch),//to control unit
.halt(halt),//to control unit
.ALUsrcA(ALUsrcA),//to muxsrcA
.ALUsrcB(ALUsrcB),//to muxsrcB
.regwrite(regwrite),//to register
.memread(memread),//to dmem and control unit
.memwrite(memwrite),//to dmem and control unit
.WBsel(WBsel),//to muxWB
.PCsel(PCsel),//to muxPC
.immsel(immsel),//to IMMGEN
.mem_datatype(mem_datatype),//to dmem
.ALU_op_d(alu_op_d)//to ALU and control unit
);

REG REG(
.clk(CLK100MHZ),
.rst(btnC),
.wb(wb),//from control unit
.regwr(regwrite),//from decoder
.inst(instr),//from IMEM
.wrdata(wrdata),//from muxWB
.wb_comp(wb_comp),//to control unit
.rs1data(rs1data),//to muxsrcA
.rs2data(rs2data)//to muxsrcB, dmem
);

IMMGEN IMM(
.inst_imm(instr),//from IMEM
.immsel_g(immsel),//
.immgen_out(immgen_out)//to PCSUM and alusrcB
);

ALU ALU(
.ALU_op(alu_op_d),//from DECODER
.input1(rs1data_mux),//from muxsrcA
.input2(rs2data_mux),//from muxsrcB
.zero(zero),//to muxBRANCHPC
.alu_out(alu_out)//to DMEM, muxPC, muxWB
);

DMEM DMEM(
.clk(CLK100MHZ),
.memread(memread),//from DECODER
.memwrite(memwrite),//from DECODER
//.mem(mem),//from control unit
//.data_type(mem_datatype),//from DECODER
.addr(alu_out),//from ALU
.wr_data(LSU_rs2),//from REG
//.mem_rd_comp(mem_rd_comp),//to control unit
//.mem_wr_comp(mem_wr_comp),//to control unit
.out_data(wr_data),//to LSU*
.switch(sw),
.byte_enable()
); 

MUX2 muxsrcA(
.sel_mux2(ALUsrcA),//from ALUsrcA
.in_mux2_a(addr),//from PC
.in_mux2_b(rs1data),//from REG
.out_mux2(rs1data_mux)//to ALU
);

MUX2 muxsrcB(
.sel_mux2(ALUsrcB),//from ALUsrcB
.in_mux2_a(rs2data),//from REG
.in_mux2_b(immgen_out),//from IMMGEN
.out_mux2(rs2data_mux)//to ALU
);

MUX2 muxBRANCHPC(
.sel_mux2(zero),//from ALUsrcB
.in_mux2_a(PC4),//from ADD4
.in_mux2_b(PCSUM),//from PCSUM
.out_mux2(branchpc)//to muxPC
);

ADD4 PCADD4(
.pc_in_a(addr),//from PC
.pc_out_a(PC4)//to muxBRANCHPC, muxPC
);

PCSUM PCADDIMM(
.pc_in_s(addr),//from PC
.imm_in_s(immgen_out),//from IMMGEN
.pc_out_s(PCSUM)//to muxBRANCHPC
);

MUX3 MUXPC(
.sel_mux3(PCsel),//from control unit
.in_mux3_a(PC4),//from ADD4
.in_mux3_b(branchpc),//from muxBRANCHPC
.in_mux3_c(alu_out),//from ALU
.out_mux3(new_count)//to PC
);

MUX3 MUXWB(
.sel_mux3(WBsel),//from control unit
.in_mux3_a(JAL_store),//from ADD4, JAL
.in_mux3_b(LSU_wr_data),//from LSU*
.in_mux3_c(alu_out),//from ALU
.out_mux3(wrdata)//to REG
);

SUBPC PC_JAL(
.PC4(PC4),
.JAL_store(JAL_store)
);

LSU loadstore(
.sign_extend(sign_extend),
.datatype(mem_datatype),//from DECODER
.addr(alu_out),//from alu
.rs2data(rs2data),//from reg
.wr_regdata(wr_data),//from DMEM
.byte_enable(byte_enable),//to MUXWB*
.LSU_regdata(LSU_wr_data),
.LSU_rs2(LSU_rs2)
);








assign LED = wr_data[15:0];
/*
always@(*)begin
    complete = halt;
end
*/
//assign seg[0] = halt;

//assign mem_out = (pick)? result[15:0]:wr_data[15:0]; 
//assign memread_data = wr_data[15:0];
//assign memwrite_data = rs2data[15:0];

endmodule
