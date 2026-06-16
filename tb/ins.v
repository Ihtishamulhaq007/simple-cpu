module instructionMemory_tb;
reg  [31:0] pc;
wire [31:0] instruction;

instructionMemory_d #(
    .ADDR_WIDTH(32),
    .DATA_WIDTH(32),
    .MEM_DEPTH(256)
) uut (
    .pc(pc),
    .instruction(instruction)
);

initial begin
    dut.mem[0] = 32'h1;
    dut.mem[1] = 32'h2;
    dut.mem[2] = 32'h3;
    dut.mem[3] = 32'h4;
    dut.mem[255] = 32;      //last addr

    pc = 0;
    #10;
    pc = 4;
    #10;
    pc = 8;
    #10;
    pc = 12;
    #10;
    pc = 1020;
    #10;
    pc = 1024;
    #10;

    $finish;

end

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, instructionMemory_tb);
end

endmodule