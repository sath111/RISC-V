module ALU #(
    parameter d_width = 32,
    parameter op = 4
)
(
    input [op -1 : 0] operator,
    input [d_width -1 : 0] a,
    input [d_width -1 : 0] b,
    output reg [d_width -1 : 0] c,
    output reg zero,
    input rst_n
);

always @(*) begin
    if(~rst_n) begin
        zero = 0;
    end
    else begin
        case(operator)
            4'b0000: c = a + b; //add
            4'b0001: c = a - b; //sub
            4'b0010: c = a << b; // sll
            4'b0011: begin //slt
                if(a[31] != b[31]) begin
                    if(a[31]) begin
                        c = 32'd1;
                    end
                    else begin
                        c = 32'd0;
                    end
                end
                else begin
                    c = (a < b) ? 1 : 0;
                end
            end
            4'b0100: c = (a < b) ? 1 : 0; //sltu
            4'b0101: c = a ^ b; //xor
            4'b0110: c = a >> b; // srl
            4'b0111: c = a >>> b; //sra
            4'b1000: c = a | b; //or
            4'b1001: c = a & b; //and
            default: c = 32'd0;
        endcase
        zero = (c == 32'd0) ? 1 : 0;
    end
end 

endmodule