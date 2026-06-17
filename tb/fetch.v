module fetch_tb;

reg  [31:0] pc;

wire [31:0] instruction;
wire [6:0]  opcode;
wire [6:0]  funct7;
wire [4:0]  rs1, rs2, rd;
wire [2:0]  funct3;

instructionMemory_d #(
    .ADDR_WIDTH(32),
    .DATA_WIDTH(32),
    .MEM_DEPTH(256)
) dut (
    .pc(pc),
    .instruction(instruction)
);

decoder_d dut1 (
    .instruction(instruction),
    .opcode(opcode),
    .funct7(funct7),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .funct3(funct3)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, fetch_tb);

    // ADD x5, x1, x2
    dut.mem[0] = 32'b0000000_00010_00001_000_00101_0110011;

    dut.mem[1] = 32'h2;
    dut.mem[2] = 32'h3;
    dut.mem[3] = 32'h4;

    dut.mem[255] = 32;      // last address

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

    pc = 1024;      // out of bounds
    #10;

    $finish;
end

endmodule