module dmem_tb;
reg clk, memRead, memWrite;
reg [31:0] addr, write_data;
wire [31:0]read_data;

dmem_d uut(
    .clk(clk),
    .memRead(memRead),
    .memWrite(memWrite),
    .addr(addr),
    .write_data(write_data),
    .read_data(read_data)
);

always #5 clk = ~clk;
initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0,dmem_tb);
    clk = 0;

    memWrite = 1;
    write_data = 32'd27;
    addr = 32'h00000000;
    #10;

    memRead = 0;
    memWrite = 1;
    write_data = 27;
    addr = 32'h00000023;
    #10 ;

    memRead = 1;
    memWrite = 0;
    addr = 32'h00000023;
    #10;

    memRead = 1;
    memWrite = 0;
    addr = 32'h00000000;
    #10;

    memRead = 0;
    memWrite = 0;
    addr = 32'h00000000;
    #10;

    memRead = 0;    
    memWrite = 1;
    write_data = 32'h12345678;
    addr = 32'h000003FC;
    #10;

    memRead = 1;
    memWrite = 0;
    addr = 32'h000003FC;
    #10;
    $finish;
end

endmodule