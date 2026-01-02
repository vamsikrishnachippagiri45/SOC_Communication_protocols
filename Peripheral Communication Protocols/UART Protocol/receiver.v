`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.12.2025 18:36:39
// Design Name: 
// Module Name: receiver
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


module receiver (clk,reset,rx,rx_en,rdy_clr,rdy,data_out);
    input        clk;
    input        reset;
    input        rx;
    input        rx_en;    //(16x baud)
    input        rdy_clr;
    output reg   rdy;
    output reg [7:0] data_out;
  
    parameter START = 2'b00,
              DATA  = 2'b01,
              STOP  = 2'b11;

    reg [1:0] present_state, next_state;
    reg [3:0] sample_count;
    reg [2:0] index;
    reg [7:0] temp_reg;

    // Sequential logic
    always @(posedge clk) 
    begin
        if (reset) begin
            present_state <= START;
            next_state <= START;
            sample_count  <= 4'd0;
            index         <= 3'd0;
            temp_reg      <= 8'd0;
            data_out      <= 8'd0;
            rdy           <= 1'b0;
        end
        else 
            begin
                present_state <= next_state;
                if (rdy_clr)
                    rdy <= 1'b0;
    
                if (rx_en) 
                    begin
                        case (present_state)
                            START: 
                                begin
                                    if (rx == 1'b0)
                                        sample_count <= sample_count + 1'b1;
                                    else
                                        sample_count <= 4'd0;
            
                                    if (sample_count == 4'd15) begin
                                        sample_count <= 4'd0;
                                        index <= 3'd0;
                                    end
                                end
        
                            DATA: 
                                begin
                                    sample_count <= sample_count + 1'b1;
                                    if (sample_count == 4'd8) 
                                    begin
                                        temp_reg[index] <= rx;
                                    end
            
                                    if (sample_count == 4'd15) 
                                    begin
                                        sample_count <= 4'd0;
                                        index <= index + 1'b1;
                                    end
                                end
        
                            STOP: 
                                begin
                                    sample_count <= sample_count + 1'b1;
                                    if (sample_count == 4'd15) 
                                    begin
                                        data_out <= temp_reg;
                                        rdy <= 1'b1;
                                        sample_count <= 4'd0;
                                    end
                                end
        
                        endcase
                    end
            end
    end

    // Next-state logic
    always @(*) 
    begin
        case (present_state)
            START: if (rx_en && sample_count == 4'd15) next_state = DATA;
            DATA:  if (rx_en && index == 3'd7 && sample_count == 4'd15) next_state = STOP;
            STOP:  if (rx_en && sample_count == 4'd15) next_state = START;
            default : next_state = present_state;
        endcase
    end

endmodule


