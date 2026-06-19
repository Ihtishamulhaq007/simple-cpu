module bjl_d(
    input [31:0]pc, imm,
    input [2:0]funct3,
    input Br, Jmp, Zero, negative,
    output reg [31:0]next_pc
);

always@(*) begin
    if(Jmp)
        next_pc = pc + imm;
    else if(Br && Zero && funct3 == 3'b000)          //ONLY BEQ for now
        next_pc = pc + imm;
    else if(Br && ~Zero && funct3 == 3'b001)        //BNE
        next_pc = pc + imm;
    else if(Br && negative && funct3 == 3'b100)     //BLT
        next_pc = pc + imm;
    else if(Br && ~negative && funct3 == 3'b101)    //BGE
        next_pc = pc + imm;
    else
        next_pc = pc + 4;
end
    

endmodule