module cpuint_d(
    input clk, rst
);

wire [31:0] pc, next_pc;
wire [31:0] instruction;

wire [4:0] write_addr;
wire [4:0] read_addr1;
wire [4:0] read_addr2;

wire [31:0] imm;

wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] read_data;

wire [31:0] alu_result;

wire [31:0] writeback_data;

wire br, jm, MemRead, MemWrite, MemToReg, RegWrite;
wire ALUSrc, carry, zero , negative, overflow;
wire [6:0] opcode, funct7;
wire [2:0] funct3;
wire [3:0] ALUControl;

assign writeback_data = (MemToReg) ? read_data : ( jm ? (pc + 4) : alu_result ) ;



pc_d PC(
        clk, 
        rst, 
        next_pc, 
        pc
    );
    
    instructionMemory_d  #(
        .MEM_DEPTH(256)             //NO of max Instruction Lines
    )InsMem(
        pc, 
        instruction
    );
        decoder_d dec(
            instruction, 
            opcode, 
            funct7, 
            read_addr1, 
            read_addr2, 
            write_addr, 
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
        br, 
        jm,
        ALUControl
    );
    regfile_d RAM(
        clk, 
        RegWrite, 
        read_addr1, 
        read_addr2, 
        write_addr, 
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
    
    dmem_d  #(
        .MEM_DEPTH(256)         //No of storage places
    )ROM(
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
    funct3,
    br, 
    jm, 
    zero, 
    negative,
    next_pc
);
endmodule