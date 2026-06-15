`timescale 1ns/1ps

module alu_tb;

reg  [3:0] a;
reg  [3:0] b;
wire [3:0] y;

alu dut (
    .a(a),
    .b(b),
    .y(y)
);

initial begin           //these two $ files are necessary for waveform dumping;
    $dumpfile("wave.vcd");
    $dumpvars(0, alu_tb);

    a = 4'd3; b = 4'd2;
    #10;

    a = 4'd5; b = 4'd1;
    #10;

    $finish;
end

endmodule