module pc_tb;
reg clk, rst;
reg [31:0]next_pc;
wire [31:0]pc;
pc_d #(
    .DATA_WIDTH(32),
    .ADDR_WIDTH(32)
) uut(
    .clk(clk),
    .rst(rst),
    .next_pc(next_pc),
    .pc(pc)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, pc_tb);
    rst = 1;
    clk = 0;
    next_pc = 0;

    #10;
    rst = 0;

    next_pc = 32'd4;
    #10;

    next_pc = 32'd8;
    #10;

    next_pc = 32'd100;
    #10;

    next_pc = 32'd24;
    #10;

    $finish;
end

endmodule