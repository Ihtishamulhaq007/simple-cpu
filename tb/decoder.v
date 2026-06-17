module decoder_tb;

    reg  [31:0] instruction;

    wire [6:0] opcode;
    wire [6:0] funct7;
    wire [4:0] rs1, rs2, rd;
    wire [2:0] funct3;

    decoder_d dut (
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
        $dumpvars(0, decoder_tb );
        // ADD x5, x1, x2
        instruction = 32'b0000000_00010_00001_000_00101_0110011;

        #10;

        $display("opcode = %b", opcode);
        $display("rd     = %d", rd);
        $display("rs1    = %d", rs1);
        $display("rs2    = %d", rs2);
        $display("funct3 = %b", funct3);
        $display("funct7 = %b", funct7);

        #10;
        $finish;

    end

endmodule