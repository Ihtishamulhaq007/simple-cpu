module immediateGenerator_tb;
reg [31:0]instruction;
wire [31:0]imm;

immediateGenerator_d uut(
    .instruction(instruction),
    .imm(imm)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, immediateGenerator_tb);

    //I +/- imm = 10, imm = 32'hFFFFFFFF
    instruction = 32'b000000001010_00000_000_00000_0010011;
    #10;    
    instruction = 32'b111111111111_00000_000_00000_0010011;
    #10;
    //S + / - imm = 12, imm = 32'hFFFFFFFC
    instruction = 32'b0000000_00000_00000_000_01100_0100011;
    #10;
    instruction = 32'b1111111_00000_00000_000_11100_0100011;
    #10;
    //B + / -   imm = 8, imm = 32'hFFFFFFF8
    instruction = 32'b0000000_00000_00000_000_01000_1100011;
    #10;
    instruction = 32'b1111111_00000_00000_000_11001_1100011;
    #10;
    //J +/-     imm = 16,   imm = 32'hFFFFFFF0
    instruction = 32'b00000000100000000000_00000_1101111;
    #10;
    instruction = 32'b11111111100111111111_00000_1101111;
    #10
    $finish;
end
endmodule