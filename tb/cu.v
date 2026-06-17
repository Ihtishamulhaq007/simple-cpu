`timescale 1ns/1ps

module cu_d_tb;

reg [6:0] opcode;
reg [6:0] funct7;
reg [2:0] funct3;

wire RegWrite;
wire MemRead;
wire MemWrite;
wire ALUSrc;
wire MemToReg;
wire Branch;
wire Jump;
wire [3:0] ALUControl;

cu_d dut (
    .opcode(opcode),
    .funct7(funct7),
    .funct3(funct3),

    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .MemToReg(MemToReg),
    .Branch(Branch),
    .Jump(Jump),
    .ALUControl(ALUControl)
);

initial begin

    $dumpfile("wave.vcd");
    $dumpvars(0, cu_d_tb);

    // ADD
    opcode = 7'b0110011;
    funct3 = 3'b000;
    funct7 = 7'b0000000;
    #10;

    // SUB
    opcode = 7'b0110011;
    funct3 = 3'b000;
    funct7 = 7'b0100000;
    #10;

    // AND
    opcode = 7'b0110011;
    funct3 = 3'b111;
    funct7 = 7'b0000000;
    #10;

    // OR
    opcode = 7'b0110011;
    funct3 = 3'b110;
    funct7 = 7'b0000000;
    #10;

    // ADDI
    opcode = 7'b0010011;
    funct3 = 3'b000;
    funct7 = 0;
    #10;

    // XORI
    opcode = 7'b0010011;
    funct3 = 3'b100;
    #10;

    // LW
    opcode = 7'b0000011;
    funct3 = 3'b010;
    #10;

    // SW
    opcode = 7'b0100011;
    funct3 = 3'b010;
    #10;

    // BEQ
    opcode = 7'b1100011;
    funct3 = 3'b000;
    #10;

    // BNE
    opcode = 7'b1100011;
    funct3 = 3'b001;
    #10;

    // BLT
    opcode = 7'b1100011;
    funct3 = 3'b100;
    #10;

    // BGE
    opcode = 7'b1100011;
    funct3 = 3'b101;
    #10;

    // JAL
    opcode = 7'b1101111;
    funct3 = 0;
    funct7 = 0;
    #10;

    $finish;

end

endmodule