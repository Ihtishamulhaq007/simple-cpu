module uart_tx #(
    parameter CLOCK_FREQUENCY = 50000000,
    parameter BAUD_RATE = 115200
)(
    input clk, rst, start,
    input [7:0] data,
    output reg tx, uart_busy
);
localparam CycPerBit = CLOCK_FREQUENCY/BAUD_RATE;

reg [7:0] shift_reg;
reg baud_tick;
reg [ $clog2(CycPerBit)-1 : 0 ] baud_ctr;
reg [2:0] bits_sent;
reg [1:0] cst;
localparam [1:0]
    IDLE  = 2'b00,
    START = 2'b01,
    DATA  = 2'b10,
    STOP  = 2'b11;
//Baud Gen
always @(posedge clk) begin
    if (rst) begin
        baud_ctr  <= 0;
        baud_tick <= 0;
        
    end
    else if (cst == IDLE) begin
        baud_ctr  <= 0;
        baud_tick <= 0;
    end
    else if (baud_ctr == CycPerBit-1) begin
        baud_ctr  <= 0;
        baud_tick <= 1;
    end
    else begin
        baud_ctr  <= baud_ctr + 1;
        baud_tick <= 0;
    end
end

//FSM
always @(posedge clk) begin
    if (rst) begin
        cst <= IDLE;
        shift_reg <= 8'b0;
        tx <= 1;
        uart_busy <= 0;
        bits_sent <= 0;
    end 
    else begin
        case (cst)
            IDLE: begin
                tx <= 1;
                uart_busy <= 0;

                if (start) begin
                    shift_reg <= data;
                    bits_sent <= 0;
                    cst <= START;
                end
            end
            START: begin
                tx <= 0;
                uart_busy <= 1;

                if (baud_tick)
                    cst <= DATA;
            end
            DATA:
                begin
                    tx <= shift_reg[0];
                    if (baud_tick) begin
                        shift_reg <= {1'b0, shift_reg[7:1]};

                        if (bits_sent == 7)
                            cst <= STOP;
                        else
                            bits_sent <= bits_sent + 1;
                    end
                end
            STOP:
                begin
                    tx <= 1;
                    if(baud_tick)
                        cst <= IDLE; 
                end
            default:
                cst <= IDLE;
        endcase
    end
end
endmodule