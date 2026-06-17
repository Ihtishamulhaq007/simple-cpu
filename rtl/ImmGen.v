module immediateGenerator_d (
    input [31:0]instruction,
    output reg [31:0]imm
);
    always@(*)
    case(instruction[6:0])
        7'b0010011:         //ADDI
            imm = {{20{instruction[31]}},
                    instruction[31:20]};
        7'b0000011:         //LW
            imm = {{20{instruction[31]}},
                    instruction[31:20]};
        7'b0100011:         // SW
            imm = {{20{instruction[31]}},
            instruction[31:25],
            instruction[11:7]};
        7'b1100011:         //B-type
            imm = {
                {19{instruction[31]}},
                instruction[31],
                instruction[7],
                instruction[30:25],
                instruction[11:8],
                1'b0
            };
        7'b1101111:          //J-type
            imm = {
                {11{instruction[31]}}, 
                instruction[31],
                instruction[19:12],
                instruction[20],
                instruction[30:21],
                1'b0
            };
        default:
            imm = 32'b0;
    endcase
endmodule