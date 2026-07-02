`timescale 1ns/1ps

module uart_tx_tb;

    localparam CLOCK_FREQUENCY = 50000000;
    localparam BAUD_RATE       = 115200;
    localparam CLK_PERIOD      = 20;      // 50 MHz

    reg clk;
    reg rst;
    reg start;
    reg [7:0] data;

    wire tx;
    wire uart_busy;

    uart_tx #(
        .CLOCK_FREQUENCY(CLOCK_FREQUENCY),
        .BAUD_RATE(BAUD_RATE)
    ) dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .data(data),
        .tx(tx),
        .uart_busy(uart_busy)
    );

    // 50 MHz clock
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    initial begin
        rst   = 1;
        start = 0;
        data  = 8'hA5;     // 1010_0101

        // Hold reset
        #100;
        rst = 0;

        // Wait a few clocks
        repeat(5) @(posedge clk);

        // One-clock start pulse
        start <= 1;
        @(posedge clk);
        start <= 0;

        // Wait until transmission finishes
        wait(uart_busy == 1);
        wait(uart_busy == 0);

        // Extra time
        repeat(150) @(posedge clk);

        $finish;
    end

    initial begin
        $dumpfile("uart_tx.vcd");
        $dumpvars(0, uart_tx_tb);
    end

endmodule