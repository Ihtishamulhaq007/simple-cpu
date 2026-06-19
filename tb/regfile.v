module regfile_tb;
reg clk,write_enable;
reg [4:0]read_addr1, read_addr2, write_addr;
reg [31:0]write_data;
wire [31:0] data1, data2;

task test;
    input write_enable_t;
    input [4:0] read_addr1_t, read_addr2_t, write_addr_t;
    input [31:0] write_data_t;
    begin
    write_enable = write_enable_t;
    read_addr1 = read_addr1_t;
    read_addr2 = read_addr2_t;
    write_addr = write_addr_t;
    write_data = write_data_t;
    #10;
    end
endtask

regfile_d #(
    .NUM_REGS(32),
    .DATA_WIDTH(32)
) uut (
    .clk(clk),
    .write_enable(write_enable),
    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_addr(write_addr),
    .write_data(write_data),
    .data1(data1),
    .data2(data2)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, regfile_tb);

    clk = 0;      //test(we,rsrc1,rsrc2,wdst,wdat);
    test(1,1,0,1,3);    //write r1 on clockedge + read r1 instantly
    test(1,1,0,0,2);    //writing x0 test
    test(1,1,3,3,7);    //DualRead
    test(0,3,3,3,1);    //SanmeRead + write off
    test(1,3,3,3,4);    //verify write off, + reading while value is being edited
    test(1,31,0,31,67);     //last reg

    test(1,0,5,5,10);   //R5 = 10
    test(1,5,0,5,20);   //edit r5 while viewing it
    $finish;
end
endmodule