module cu_d #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32,
    parameter ALU_DEPTH  = 11
)(
    input [6:0] opcode, funct7,
    input [2:0] funct3,
    output reg RegWrite, MemRead, MemWrite, ALUSrc, MemToReg, Branch, Jump,
    output reg [$clog2(ALU_DEPTH)-1:0] ALUControl
);

    always@(*)
    begin
        RegWrite   = 0;
        MemRead    = 0;
        MemWrite   = 0;
        ALUSrc     = 0;
        MemToReg   = 0; 
        Branch     = 0; 
        Jump       = 0;
        ALUControl = 0; 

        case(opcode)
            7'b0110011:     //R-type
                begin
                    RegWrite = 1;
                    MemRead = 0;
                    MemWrite = 0;
                    ALUSrc = 0;
                    MemToReg = 0;
                    Branch = 0;
                    Jump = 0;

                    case(funct3)
                    3'b000:
                        case(funct7)
                            7'b0000000: //ADD
                                ALUControl = 4'b0000;
                            7'b0100000:  //SUB
                                ALUControl = 4'b0001;
                        endcase
                    3'b001: //SLL
                        ALUControl = 4'b0101;
                    3'b010: //SLT
                        ALUControl = 4'b0111;
                    3'b011: //SLTU
                        ALUControl = 4'b1000;
                    3'b100:  //XOR
                        ALUControl = 4'b0100;
                    3'b101: //SR
                        case(funct7)
                            7'b0000000:   //SRL
                                ALUControl = 4'b0110;
                            7'b0100000:   //SRA
                                ALUControl = 4'b1011;
                        endcase
                    3'b110: //OR
                        ALUControl = 4'b0011;
                    3'b111: //AND
                        ALUControl = 4'b0010;
                    endcase
                end
            7'b0010011:     //I-type
                begin
                    RegWrite = 1;
                    MemRead = 0;
                    MemWrite =0;
                    ALUSrc = 1;
                    MemToReg = 0;
                    Branch = 0;
                    Jump = 0;

                    case(funct3)
                        3'b000:     //ADDI
                            ALUControl = 4'b0000;
                        3'b100:     //XORI
                            ALUControl = 4'b0100;
                        3'b110:     //ORI
                            ALUControl = 4'b0011;
                        3'b111:     //ANDI
                            ALUControl = 4'b0010;
                    endcase
                end
            7'b0000011:     //LW
                begin
                    RegWrite = 1;
                    MemRead = 1;
                    MemWrite = 0;
                    ALUSrc = 1;
                    MemToReg = 1;
                    Branch = 0;
                    Jump = 0;

                    if(funct3 == 3'b010)     //confirming func3 for safety
                        ALUControl = 4'b0000;
                end
            7'b0100011:     //SW
                begin
                    RegWrite = 0;
                    MemRead = 0;
                    MemWrite = 1;
                    ALUSrc = 1;
                    MemToReg = 1'bx;       //dont care
                    Branch = 0;
                    Jump = 0;

                    if(funct3 == 3'b010)
                        ALUControl = 4'b0000;
                end
            7'b1100011:     //B-type
                begin
                    RegWrite = 0;
                    MemRead = 0;
                    MemWrite = 0;
                    ALUSrc = 0;
                    MemToReg = 1'bx;
                    Branch = 1;
                    Jump = 0;

                    case(funct3)
                        3'b000:     //BEQ
                            ALUControl = 4'b0001;
                        3'b001:     //BNE
                            ALUControl = 4'b0001;
                        3'b100:     //BLT
                            ALUControl = 4'b0111;
                        3'b101:     //BGE
                            ALUControl = 4'b0111;
                    endcase
                end
            7'b1101111:     //J
                begin
                    RegWrite = 1;
                    MemRead = 0;
                    MemWrite = 0;
                    ALUSrc = 0;
                    MemToReg = 1'bx;
                    Branch = 0;
                    Jump = 1;
                end
        endcase
    end
endmodule