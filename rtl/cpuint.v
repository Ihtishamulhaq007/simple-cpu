module cpuint_d(
    input clk, rst
);

wire [31:0] pc, next_pc;
wire [31:0] instruction;

wire [4:0] rd;
wire [4:0] rs1;
wire [4:0] rs2;

wire [31:0] imm;

wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] read_data;

wire [31:0] alu_result;

wire [31:0] writeback_data;

wire Br, Jm, MemRead, MemWrite, MemToReg, RegWrite;
wire ALUSrc, carry, zero , negative, overflow;
wire [6:0] opcode, funct7;
wire [2:0] funct3;
wire [3:0] ALUControl;

assign writeback_data = (MemToReg) ? read_data : alu_result ;

pc_d PC(
        clk, 
        rst, 
        next_pc, 
        pc
    );
    
    instructionMemory_d InsMem(
        pc, 
        instruction
    );
        decoder_d dec(
            instruction, 
            opcode, 
            funct7, 
            rs1, 
            rs2, 
            rd, 
            funct3
        );
        immediateGenerator_d img(
            instruction, 
            imm
        );

    cu_d CU(
        opcode, 
        funct7, 
        funct3, 
        RegWrite, 
        MemRead, 
        MemWrite, 
        ALUSrc, 
        MemToReg, 
        Br, 
        Jm,
        ALUControl
    );
    regfile_d RAM(
        clk, 
        RegWrite, 
        rs1, 
        rs2, 
        rd, 
        writeback_data, 
        read_data1, 
        read_data2
    );
    alu_d ALU(
        read_data1, 
        (ALUSrc)? imm : read_data2 , 
        ALUControl, 
        alu_result, 
        carry, 
        zero, 
        overflow, 
        negative
    );
    
    dmem_d ROM(
        clk, 
        MemRead, 
        MemWrite, 
        alu_result,     //addr      in SW
        read_data2,
        read_data
    );
bjl_d bjl(
    pc, 
    imm, 
    Br, 
    Jm, 
    zero, 
    next_pc
);
endmodule