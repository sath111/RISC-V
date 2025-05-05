module MUX41(
    input [1:0] select,
    input [31:0] a, b, c, d,
    output reg [31:0] y
);

always@(*) begin
    case(select)
        2'b00: y = a;
        2'b01: y = b;
        2'b10: y = c;
        2'b11: y = d;
        default: y = 32'd0; 
    endcase
end

endmodule