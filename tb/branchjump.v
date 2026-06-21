module bjl_tb;

reg [31:0] pc, imm;
reg br, jm, Zero, Negative;
reg [2:0]funct3;
wire [31:0] next_pc;

bjl_d DUT(
    .pc(pc),
    .imm(imm),
    .br(br),
    .jm(jm),
    .Zero(Zero),
    .next_pc(next_pc),
    .funct3(funct3),
    .negative(Negative)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, bjl_tb);

    pc = 100;
    imm = 16;

    // Normal
    br = 0;
    Negative = 0;
    funct3 = 3'b000;
    jm = 0;
    Zero = 0;
    
    #10;

    // BEQ taken
    funct3 = 3'b000;
    br = 1;
    jm = 0;
    Zero = 1;
    #10;

    // BEQ not taken
    funct3 = 3'b000;
    br = 1;
    jm = 0;
    Zero = 0;
    #10;    
    
    // BNE taken
    funct3 = 3'b001;
    br = 1;
    jm = 0; 
    Zero = 1;
    #10;
    
    // BNE not taken
    funct3 = 3'b001;
    br = 1;
    jm = 0; 
    Zero = 0;
    #10;

    //BLT taken
    funct3 = 3'b100;
    br = 1;
    jm = 0;
    Zero = 0;
    Negative = 1;
    #10;

    //BLT not taken
    funct3 = 3'b100;
    br = 1;
    jm = 0;
    Zero = 0;
    Negative = 0;
    #10;

    //BGE taken
    funct3 = 3'b101;
    br = 1;
    jm = 0;
    Zero = 0;
    Negative = 1;
    #10;

    //BGE not taken
    funct3 = 3'b101;
    br = 1;
    jm = 0;
    Zero = 0;
    Negative = 0;

    #10; 
        // JAL
    br = 0;
    jm = 1;
    Zero = 0;
    #10;

    // JAL priority
    br = 1;
    jm = 1;
    Zero = 1;
    #10;
    $finish;

end

endmodule