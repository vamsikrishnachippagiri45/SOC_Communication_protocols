`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.12.2025 19:16:29
// Design Name: 
// Module Name: transmitter
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


module transmitter (clk,reset,wr_en,en,data_in,tx,busy);
    input  clk;
    input  reset;
    input  wr_en;    // write request for 1 cycle
    input  en;        // baud tick
    input  [7:0] data_in;
    output reg   tx;
    output  busy;
  
    parameter IDLE  = 2'b00,
              START = 2'b01,
              DATA  = 2'b10,
              STOP  = 2'b11;

    reg [1:0] present_state, next_state;
    reg [7:0] data;
    reg [2:0] index;

    
    // Sequential logic
    always @(posedge clk) 
    begin
        if (reset) 
            begin
                present_state <= IDLE;
                next_state <= IDLE;
                tx            <= 1'b1;
                index         <= 3'b000;
                data          <= 8'h00;
            end
        else 
            begin
                present_state <= next_state;
                if (present_state == IDLE && wr_en) 
                    begin
                        data  <= data_in;
                        index <= 3'b000;
                    end
    
                if(en) 
                    begin
                        case (present_state)
                                START: tx <= 1'b0;
                                DATA: 
                                    begin
                                        tx <= data[index];
                                        index <= index + 1'b1;
                                    end
                                STOP: tx <= 1'b1;
                        endcase
                    end
            end
    end

    // Next-state combinational logic
    always @(*) 
        begin
            case (present_state)
                IDLE:  if (wr_en)        next_state = START;
                START: if (en)           next_state = DATA;
                DATA:  if (en && index == 3'b111) next_state = STOP;
                STOP:  if (en)           next_state = IDLE;
                default : next_state = present_state;
            endcase
        end

    assign busy = (present_state != IDLE);

endmodule

