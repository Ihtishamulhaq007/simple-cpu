    module alu_d #(
        parameter DATA_WIDTH = 32
    )(
        input [DATA_WIDTH-1:0]a,b,
        input [3:0]mode,
        output reg [DATA_WIDTH-1:0]y,
        output reg carry, zero, overflow, negative
    );
    reg [DATA_WIDTH:0] temp;

    always@(*) begin
        y=0;
        carry =0;
        overflow = 0;

        case(mode)          //<size>'<type><value>
            4'b0000 : begin     //ADD
                temp = {1'b0,a} + {1'b0,b};
                y = temp[DATA_WIDTH-1:0];
                carry = temp[DATA_WIDTH];

                overflow = (a[DATA_WIDTH-1] == b[DATA_WIDTH-1]) && (a[DATA_WIDTH-1] != y[DATA_WIDTH-1]);
            end    
            4'b0001 : begin     //SUB
                temp = {1'b0,a} - {1'b0,b};    
                y = temp[DATA_WIDTH-1:0];                 
                carry = ~(a<b);                   
                overflow = (a[DATA_WIDTH-1] != b[DATA_WIDTH-1] && (a[DATA_WIDTH-1] != y[DATA_WIDTH-1]));
            end
            4'b0010 : y = a&b;
            4'b0011 : y = a|b;

            4'b0100 : y = a^b;
            4'b0101 : y = a<<b[$clog2(DATA_WIDTH)-1:0];         //SLL using unsigned vector
            4'b0110 : y = a>>b[$clog2(DATA_WIDTH)-1:0];         //SRL                        
            4'b0111 : y = ($signed(a)<$signed(b))? 1 : 0;         //SLT

            4'b1000 : y = ($unsigned(a) < $unsigned(b))? 1 : 0; //SLTU
            4'b1001 : y = a;            //PASS_A
            4'b1010 : y = b;            //PASS_B
            4'b1011 : y = $signed(a) >>> b[$clog2(DATA_WIDTH)-1:0];        //SRA

            default : y = 0;
            
        endcase
        zero = y==0;
        negative = y[DATA_WIDTH-1];
        
    end

    endmodule