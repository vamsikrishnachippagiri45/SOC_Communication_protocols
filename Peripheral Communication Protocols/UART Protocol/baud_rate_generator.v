module baud_rate_generator (clk,reset,tx_en,rx_en);
    input  clk;
    input  reset;
    output reg tx_en;
    output reg rx_en;
  
    parameter clk_freq  = 100_000_000;
    parameter baud_rate = 9600;

    localparam integer div_tx = clk_freq / baud_rate;
    localparam integer div_rx = clk_freq / (16 * baud_rate);

    reg [$clog2(div_tx)-1:0] counter_tx;
    reg [$clog2(div_rx)-1:0] counter_rx;

    // TX baud enable
    always @(posedge clk) begin
        if (reset) begin
            counter_tx <= 0;
            tx_en      <= 1'b0;
        end
        else if (counter_tx == div_tx-1) begin
            counter_tx <= 0;
            tx_en      <= 1'b1;   
        end
        else begin
            counter_tx <= counter_tx + 1'b1;
            tx_en      <= 1'b0;
        end
    end

    // RX oversampling enable (16x)
    always @(posedge clk) begin
        if (reset) begin
            counter_rx <= 0;
            rx_en      <= 1'b0;
        end
        else if (counter_rx == div_rx-1) begin
            counter_rx <= 0;
            rx_en      <= 1'b1;   
        end
        else begin
            counter_rx <= counter_rx + 1'b1;
            rx_en      <= 1'b0;
        end
    end

endmodule

