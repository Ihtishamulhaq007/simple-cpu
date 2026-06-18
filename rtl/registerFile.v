module regfile_d #(
    parameter NUM_REGS = 32, DATA_WIDTH = 32
)(
    input clk, write_enable,
    input [$clog2(NUM_REGS)-1:0] read_addr1, read_addr2, write_addr,
    input [DATA_WIDTH-1:0] write_data,
    output reg [DATA_WIDTH-1:0] data1, data2
);
    reg [DATA_WIDTH-1 : 0] regs[0: NUM_REGS-1];
    //assign regs[0] = 0;         //RISC-V 
    always@(read_addr1 or read_addr2) 
        begin     //READ- async
            data1 = read_addr1 ? regs[read_addr1] : 0;
            data2 = read_addr2 ? regs[read_addr2] : 0;
        end
    always@(posedge clk) 
        if(write_enable == 1)  //WRITE- sync
            if(write_addr != 0)  //preventing change in x0
                regs[write_addr] <= write_data;
        
endmodule