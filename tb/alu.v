
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

        test(4,5,0);        //ADD , carry
        test(0,0,0);     
        test(32'h7FFFFFFF,1,0);     //+ overflow
        test(32'h80000000,-1,0);     //- overflow 
        test(32'h80000000, 32'h80000000, 0); //zero 
        test(32'hFFFFFFFF, 1, 0);           //-1 + 1
        test(32'h40000000, 32'h40000000, 0);
        test(32'hFFFFFFFF,32'd1,0);

        test(4,5,1);        //SUB , negative, carry (!borrow)
        test(0,0,1);
        test(5,5,1);                    //zero
        test(1,0,1);
        test(0,1,1);
        test(0,32'h80000000,1);         //pulling negative's higher bound onto positive
        test(32'h80000000,1,1);         //- overflow
        test(32'h7FFFFFFF,32'hFFFFFFFF,1);  //+ overflow

        test(-1,1,7);       //SLT <<
        test(32'h80000000,0,7);         
        test(32'h7FFFFFFF,32'h80000000,7);

        test(-1,1,8);       //SLTU <<
        test(32'h80000000,0,8);         
        test(32'h7FFFFFFF,32'h80000000,8);

        test(32'h80000000,31,5);    //SLL
        test(-23,2,5);
        test(-23,0,5);

        test(32'h80000000,31,6);    //SRL
        test(32'hFFFFFFFF,31,6);

        test(-23,0,11);             //SRA
        test(32'h80000000,32,11);   //eq. to no shift because only 5 bits are used!
        test(32'h80000000,31,11);   //Differentiator b/w SRL and SRA        
        test(-23,0,11);


        $finish;
    end
    

endmodule