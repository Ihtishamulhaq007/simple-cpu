module instructionMemory_d #(           //this module is not fuly parameterized
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter MEM_DEPTH  = 256
) (
    input  [ADDR_WIDTH-1:0] pc,
    output reg [31:0] instruction
);

reg [DATA_WIDTH-1:0] mem [0:MEM_DEPTH-1];
    
always@(*) begin
    instruction = mem[pc>>2]; //0-4-8-12...
end

endmodule