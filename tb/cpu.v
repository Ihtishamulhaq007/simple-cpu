module cpuint_tb;
reg clk,rst;
integer i = 1;
//Please check the time in the recorded screenshots in /docs/WaveForms to make more sense, it is mapped accordingly
cpuint_d CPU(clk, rst);
always #5 clk = ~clk;

initial begin   
    $dumpfile("wave.vcd");
        $dumpvars(0,cpuint_tb);
        $dumpvars(0,CPU.RAM.regs[1]);
        $dumpvars(0,CPU.RAM.regs[3]);
        $dumpvars(0,CPU.RAM.regs[4]);
        $dumpvars(0,CPU.RAM.regs[2]);
        $dumpvars(0,CPU.RAM.regs[5 ]);
        $dumpvars(0,CPU.ROM.Mem[108>>2]);

    CPU.InsMem.Imem[0] = 32'h00500093;         //ADDI x1, x0, 5      
        CPU.InsMem.Imem[1] = 32'h00A00113;    //ADDI x2, x0, 10     
       CPU.InsMem.Imem[2] = 32'h002081B3;    //ADD  x3, x1, x2     TEST1
    CPU.InsMem.Imem[4] = 32'h06400093;                          //TEST2
        CPU.InsMem.Imem[5] = 32'h02A00293;
        CPU.InsMem.Imem[6] = 32'h0050A423;
        CPU.InsMem.Imem[7] = 32'h0080A303;
    CPU.InsMem.Imem[9] = 32'h00100093; // ADDI x1,x0,1          BrancHTest
       CPU.InsMem.Imem[10] = 32'h00100113; // ADDI x2,x0,1
       CPU.InsMem.Imem[11] = 32'h00208463; // BEQ  x1,x2,+8
       CPU.InsMem.Imem[12] = 32'h06300193; // ADDI x3,x0,99
       CPU.InsMem.Imem[13] = 32'h03700213; // ADDI x4,x0,55
    CPU.InsMem.Imem[15] = 32'h00100093; // ADDI x1,x0,1         
       CPU.InsMem.Imem[16] = 32'h00100113; // ADDI x2,x0,1
       CPU.InsMem.Imem[17] = 32'h00209463; // BNE  x1,x2,+8
       CPU.InsMem.Imem[18] = 32'h06300193; // ADDI x3,x0,99
       CPU.InsMem.Imem[19] = 32'h03700213; // ADDI x4,x0,55
    CPU.InsMem.Imem[21] = 32'h00A00093; // ADDI x1,x0,10        JAL_TEST
        CPU.InsMem.Imem[22] = 32'h008002EF; // JAL  x5,+8
        CPU.InsMem.Imem[23] = 32'h06300113; // ADDI x2,x0,99
        CPU.InsMem.Imem[24] = 32'h03700193; // ADDI x3,x0,55
    clk = 0;
        rst = 1;
        #10 rst = 0;        

    #30;        //since 3rd op
    if(CPU.RAM.regs[3] == 10 + 5)
        $display("SUCCESS!");
    else
        $display("Fail : %d", CPU.RAM.regs[3]);
    #47.5;
    if(CPU.ROM.Mem[108>>2]==42 && CPU.RAM.regs[6]==42)
        $display("SW, LW SUCCESS!");
    #50;
    if(CPU.RAM.regs[3] == 15 &&   CPU.RAM.regs[4] == 55)
        $display("BEQ SUCCESS!");
    else
        $display("BEQ FAIL");
    #60;
    if(CPU.RAM.regs[3] == 99 && CPU.RAM.regs[4] == 55)
        $display("BNE SUCCESS!");
    else    
        $display("BNE FAIL");

    #60;
    if(CPU.RAM.regs[1] == 10 && CPU.RAM.regs[2] == 1 && CPU.RAM.regs[3] == 55)
        $display("JAL SUCCESS!");
    else
        $display("JAL FAIL");

    #40;       //Give 10-15 units per instruction
    $finish;
end

always@(negedge clk)
    begin
        $display("\n\tInstruction %d", i++);
       case(CPU.CU.opcode)
            7'b0110011:     //R-type
                begin
                    $write("R-type : ");
                    case(CPU.CU.funct3)
                    3'b000:
                        case(CPU.CU.funct7)
                            7'b0000000: //ADD
                                $display("ADD");
                            7'b0100000:  //SUB
                                $display("SUB");
                        endcase
                    3'b001: //SLL
                                $display("SLL");
                    3'b010: //SLT
                                $display("SLT");
                    3'b011: //SLTU
                                $display("SLTU");
                    3'b100:  //XOR
                                $display("XOR");
                    3'b101: //SR
                        case(CPU.CU.funct7)
                            7'b0000000:   //SRL
                                $display("SRL");
                            7'b0100000:   //SRA
                                $display("SRA");
                        endcase
                    3'b110: //OR
                        $display("OR");
                    3'b111: //AND
                        $display("AND");
                    endcase
                end
            7'b0010011:     //I-type
                begin
                    $write("I-type : ");
                    case(CPU.CU.funct3)
                        3'b000:     //ADDI
                            $display("ADDI");
                        3'b100:     //XORI
                            $display("XORI");
                        3'b110:     //ORI
                            $display("ORI");
                        3'b111:     //ANDI
                            $display("ANDI");
                    endcase
                end
            7'b0000011:     //LW
                    if(CPU.CU.funct3 == 3'b010)     //confirming func3 for safety
                        $display("LoadWord");
                    else
                        $display("invalid instruction");
            7'b0100011:     //SW
                    if(CPU.CU.funct3 == 3'b010)     //confirming func3 for safety
                        $display("SAVEWord");
                    else
                        $display("invalid instruction");
            7'b1100011:     //B-type
                begin
                    $write("B-type : ");
                    case(CPU.CU.funct3)
                        3'b000:     //BEQ
                            $display("BEQ");
                        3'b001:     //BNE
                            $display("BNE");
                        3'b100:     //BLT
                            $display("BLT");
                        3'b101:     //BGE
                            $display("BGE");
                    endcase
                end
            7'b1101111:     //J
                
                    $write("J-type : ");
            default:
                $display("Invalid||Null instruction");

        endcase 
    end


endmodule