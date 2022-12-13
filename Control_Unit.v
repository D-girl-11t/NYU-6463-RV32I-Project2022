`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2022 05:00:18 PM
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit(
input clk,
input pc_update,
input instr_fetched,
input regwrite,
input branch,
input halt,
input memwrite, memread,
input id_comp, wb_comp, 
//input mem_rd_comp, mem_wr_comp, 
input wire[4:0] alu_op_d,
output reg decode,
output reg PCwrite,
output reg instrfetch, wb 
//output reg mem
    );

reg[2:0] state, next_state;    
parameter IF = 3'd0, ID = 3'd1, WB = 3'd2, PC = 3'd3, halted = 3'd4;

always@(state, halt, pc_update, id_comp, instr_fetched, wb_comp)begin
    case(state)
        // idle state
        /*
        idle: begin
            if (halt)
                next_state <= halt;
            else begin
                PCwrite <= 1; 
                if (pc_update) begin
                        next_state <= IF;
                        pc_update <= 0;
                        PCwrite <= 0;
                end    
                else 
                    next_state <= idle;
            end
        end
        */
        // instruction fetch state
        IF: begin
            if (halt)
                next_state <= halted;
            else begin
                instrfetch <= 1;
                if (instr_fetched) begin
                    next_state <= ID;
                    instrfetch <= 0;
                end
                else 
                    next_state <= IF;
            end
        end
        // instruction decode state
        ID: begin
            if (halt)
                next_state <= halted;
                else begin
                    decode <= 1;
                    if(id_comp) begin
                    /*
                        if (memwrite == 1 )begin // only instruction that need to use DMEM will go to MEM state
                            next_state <= MEM;
                            decode <= 0;
                        end
                        else if (memread == 1)begin // only instruction that need to use DMEM will go to MEM state
                            next_state <= MEM;
                            decode <= 0;
                        end
                        */
                        // try no MEM state
                        if (branch ==1) begin// branch instruction go straight to PC determination 
                            next_state <= PC;
                            decode <= 0;
                        end
                        else begin //no memread/memwrite or branch so go straight to WB state
                            next_state <= WB;
                            decode <= 0;
                        end
                    end        
                    else
                        next_state <= ID;                            
                end
        end
        /*
        MEM: begin
            if (halt)
                next_state <= halted;
            else begin
                mem <= 1;
                if(mem_rd_comp) begin
                    if (regwrite == 1) begin
                        next_state <= WB;//load instruction go to WB
                        mem <= 0;
                    end
                    else begin
                        next_state <= PC;//store instruction go straight to PC
                        mem <= 0;
                    end
                end
                if(mem_wr_comp) begin
                    next_state <= PC;
                    mem <= 0;    
                end
                */
                    /*
                    else if (regwrite == 0) begin
                        next_state <= PC;//store instruction go straight to PC
                        mem <= 0;
                    end
                    */
                    /*
                if(mem_rd_comp) begin
                    next_state <= WB;//load instruction go to WB
                    mem <= 0;
                end
                else if(mem_wr_comp)begin
                    next_state <= PC;
                    mem <= 0;    
                end
                    
                else
                    next_state <= MEM;
            end
        end
        */ 
        WB: begin
            if (halt)
                next_state <= halted;
            else begin
                wb <= 1;
                if(wb_comp) begin
                    next_state <= PC;
                    wb <= 0;
                end
                else if (memwrite) begin
                    next_state <= PC;
                   
                end    
                else
                    next_state <= WB;
            end
        end
        PC: begin
            if (halt)
                next_state <= halted;
            else begin
                PCwrite <= 1;
                if(pc_update) begin
                    next_state <= IF;
                    PCwrite <= 0;
                end    
                else
                    next_state <= PC;
            end       
        end
        halted: begin
            next_state <= halted;
            instrfetch <= 0;
            decode <= 0;
            //mem <= 0;
            wb <= 0;
            PCwrite <= 0;
        end
        default: next_state <= IF;        
    endcase    
 end
 
 always@(posedge clk) begin
    state <= next_state;
 end                   

endmodule
