module cpuint_tb;
reg clk,rst;

cpuint_d CPU(
    clk,
    rst
);

always #5 clk = ~clk;

initial begin
    CPU.InsMem.Imem[0] = 32'h00500093;
    CPU.InsMem.Imem[1] = 32'h00A00113;
    CPU.InsMem.Imem[2] = 32'h002081B3;


    CPU.InsMem.Imem[4] = 32'h06400093;
    CPU.InsMem.Imem[5] = 32'h02A00293;
    CPU.InsMem.Imem[6] = 32'h0050A423;
    CPU.InsMem.Imem[7] = 32'h0080A303;

    $dumpfile("wave.vcd");
    $dumpvars(0,cpuint_tb);
    
    clk = 0;
    rst = 1;
    #10 rst = 0;
    #35
    $finish;
end
endmodule