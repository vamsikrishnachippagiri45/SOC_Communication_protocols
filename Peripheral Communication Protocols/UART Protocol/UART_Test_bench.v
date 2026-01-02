`timescale 1ns/1ps

module UART_Test_bench;

    // ------------------------
    // Clock & Reset
    // ------------------------
    reg clk;
    reg reset;

    // ------------------------
    // UART signals
    // ------------------------
    reg  [7:0] data_in;
    reg        wr_en;
    reg        rdy_clr;
    wire       rdy;
    wire       busy;
    wire [7:0] data_out;

    // ------------------------
    // DUT instantiation
    // ------------------------
    UART_Top DUT (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .wr_en(wr_en),
        .rdy_clr(rdy_clr),
        .rdy(rdy),
        .busy(busy),
        .data_out(data_out)
    );

    // ------------------------
    // Clock generation
    // 100 MHz → 10 ns period
    // ------------------------
    always #5 clk = ~clk;

    // ------------------------
    // Test sequence
    // ------------------------
    initial begin
        // Initialize
        clk     = 0;
        reset   = 1;
        wr_en   = 0;
        rdy_clr = 0;
        data_in = 8'h00;

        // Apply reset
        #100;
        reset = 0;

        // Wait a few cycles
        #100;

        // ------------------------
        // Send 1 byte
        // ------------------------
        data_in = 8'hA5;   // Test byte
        wr_en   = 1'b1;
        #10;
        wr_en   = 1'b0;

        // ------------------------
        // Wait for reception
        // ------------------------
        wait (rdy == 1'b1);

        // Small delay to stabilize
        #20;

        // ------------------------
        // Check received data
        // ------------------------
        if (data_out == 8'hA5)
            $display("SUCCESS: Received data = %h", data_out);
        else
            $display("ERROR: Expected A5, Received = %h", data_out);

        // Clear ready flag
        rdy_clr = 1'b1;
        #10;
        rdy_clr = 1'b0;

        // End simulation
        #200;
        $stop;
    end

endmodule

