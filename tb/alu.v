
module alu_tb;
    reg [31:0] a,b;
    reg [3:0] mode;
    wire  [31:0] Y;
    wire carry, zero, overflow, negative;
    integer i;
task test;
    input [31:0] a_t, b_t;
    input [3:0] mode_t;
    begin
        a = a_t;
        b = b_t;
        mode = mode_t;
        #10;
    end
endtask
    alu_d uut(
        .a(a),
        .b(b),
        .mode(mode),
        .y(Y),
        .carry(carry),
        .zero(zero),
        .overflow(overflow),
        .negative(negative)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, alu_tb);
        mode =0;
        
        test(4,5,0);
        test(0,1,1);
        test(32'h7FFFFFFF,1,0);     //
        test()
        

        $finish;
    end
    

endmodule