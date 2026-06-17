module dmem_d #(
    parameter DATA_WIDTH = 32,
    parameter MEM_DEPTH = 256,
    parameter ADDR_WIDTH = 32               
)(
    input clk, memRead, memWrite,
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] write_data,
    output reg [DATA_WIDTH-1:0] read_data
);
    reg [DATA_WIDTH-1:0] Mem [0:MEM_DEPTH-1];

    always@(*) begin        //Async READ
        if(memRead)
            read_data = Mem[addr>>2];
        else
            read_data = {DATA_WIDTH{1'bx}};
    end

    always @(posedge clk) begin
        if(memWrite)
            Mem[addr>>2] <= write_data;
    end

endmodule