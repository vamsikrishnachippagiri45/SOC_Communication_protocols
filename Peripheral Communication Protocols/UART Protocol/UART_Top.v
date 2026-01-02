`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.12.2025 19:12:37
// Design Name: 
// Module Name: UART_Top
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


module UART_Top(clk , reset , data_in , wr_en ,rdy_clr ,rdy , busy , data_out );
input clk,reset,wr_en,rdy_clr;
input [7:0]data_in;
output rdy,busy;
output [7:0]data_out;

wire tx_clk_en,rx_clk_en;
wire tx_temp;
baud_rate_generator BRG(.clk(clk),.reset(reset),.tx_en(tx_clk_en),.rx_en(rx_clk_en));
transmitter TX(.clk(clk) , .wr_en(wr_en), .en(tx_clk_en) , .reset(reset) , .data_in(data_in) , .busy(busy) , .tx(tx_temp));
receiver RX(.clk(clk) , .reset(reset) , .rx(tx_temp) , .rx_en(rx_clk_en) , .rdy_clr(rdy_clr) , .rdy(rdy) , .data_out(data_out));
endmodule

