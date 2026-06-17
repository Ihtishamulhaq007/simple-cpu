module bjl_d(
    input [31:0]pc, imm,
    input Br, Jmp, Zero,
    output reg [31:0]next_pc
);

always@(*) begin
    if(Jmp)
        next_pc = pc + imm;
    else if(Br && Zero)          //ONLY BEQ for now
        next_pc = pc + imm;
    else 
        next_pc = pc + 4;
end
    

endmodule