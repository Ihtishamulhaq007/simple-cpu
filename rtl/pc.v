module pc_d #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 32
)(
    input clk, rst, 
    input [(ADDR_WIDTH) -1:0]next_pc,
    output reg [(ADDR_WIDTH) -1:0]pc
);

    //32' => 2^32/4 instructions

    always@(posedge clk) begin
        if(rst)
            pc <= 0;
        else
            pc <= next_pc;
    end
endmodule