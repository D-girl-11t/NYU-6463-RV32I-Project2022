`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/14/2022 11:05:30 PM
// Design Name: 
// Module Name: LSU
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


module LSU(
input sign_extend,
input[1:0] datatype,
input[31:0] addr, rs2data, wr_regdata,
output reg[3:0] byte_enable,
output reg[31:0] LSU_regdata, LSU_rs2
    );

wire[1:0] offset;

assign offset = addr[1:0];
    
always@(*) begin
case(datatype)
    2'b00: begin //byte
        LSU_rs2 <= rs2data[7:0];//byte
        case(offset)
        2'b00: byte_enable <= 4'b0001;
        2'b01: byte_enable <= 4'b0010;
        2'b10: byte_enable <= 4'b0100;
        2'b11: byte_enable <= 4'b1000;
        default: byte_enable <= 4'b1111;
        endcase
    end    
    2'b01: begin //half word
        LSU_rs2 <= rs2data[15:0];//byte
        case(offset)
        2'b00: byte_enable <= 4'b0011;
        2'b01: byte_enable <= 4'b0110;
        2'b10: byte_enable <= 4'b1100;
        2'b11: byte_enable <= 4'b1000;
        default: byte_enable <= 4'b1111;
        endcase
    end
    2'b10: begin //word
        LSU_rs2 <= rs2data[31:0];//byte
        case(offset)
        2'b00: byte_enable <= 4'b1111;
        2'b01: byte_enable <= 4'b1110;
        2'b10: byte_enable <= 4'b1100;
        2'b11: byte_enable <= 4'b1000;
        default: byte_enable <= 4'b1111;
        endcase
    end
    default: begin
        byte_enable <= 4'b1111;
        LSU_rs2 <= rs2data[31:0];
    end
endcase
end        

always@(*) begin
case(datatype)
    2'b00: begin // byte LB, LBU
        if(sign_extend) begin
            case(offset)
                2'b00: LSU_regdata <= {{24{wr_regdata[7]}},wr_regdata[7:0]};
                2'b01: LSU_regdata <= {{24{wr_regdata[15]}},wr_regdata[15:8]};
                2'b10: LSU_regdata <= {{24{wr_regdata[23]}},wr_regdata[23:16]};
                2'b11: LSU_regdata <= {{24{wr_regdata[31]}},wr_regdata[31:24]};
                default: LSU_regdata <= {{24{wr_regdata[7]}},wr_regdata[7:0]};
            endcase
        end
        else begin
            case(offset)
                2'b00: LSU_regdata <= {24'b0,wr_regdata[7:0]};
                2'b01: LSU_regdata <= {24'b0,wr_regdata[15:8]};
                2'b10: LSU_regdata <= {24'b0,wr_regdata[23:16]};
                2'b11: LSU_regdata <= {24'b0,wr_regdata[31:24]};
                default: LSU_regdata <= {24'b0,wr_regdata[7:0]};
            endcase
        end
    end
    2'b01: begin //half word, LH, LHU
        if(sign_extend) begin
            case(offset)
                2'b00: LSU_regdata <= {{16{wr_regdata[15]}},wr_regdata[15:0]};
                2'b01: LSU_regdata <= {{16{wr_regdata[23]}},wr_regdata[23:8]};
                2'b10: LSU_regdata <= {{16{wr_regdata[31]}},wr_regdata[31:16]};
                2'b11: LSU_regdata <= {{16{wr_regdata[31]}},{wr_regdata[7:0]},{wr_regdata[31:24]}};
                default: LSU_regdata <= {{16{wr_regdata[15]}},wr_regdata[7:0]};
            endcase
        end
        else begin 
            case(offset)
                2'b00: LSU_regdata <= {16'b0,wr_regdata[15:0]};
                2'b01: LSU_regdata <= {16'b0,wr_regdata[23:8]};
                2'b10: LSU_regdata <= {16'b0,wr_regdata[31:16]};
                2'b11: LSU_regdata <= {16'b0,{wr_regdata[7:0]},{wr_regdata[31:24]}};
                default: LSU_regdata <= {16'b0,wr_regdata[15:0]};
            endcase
        end
    end
    default: LSU_regdata <= wr_regdata[31:0];
endcase
end
     
   
endmodule
