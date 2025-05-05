module PCv1(
    input clk, en,rst_n,
    input [7:0] PC,
    output reg [7:0] PC_current
);

always@(posedge clk) begin
    if(~rst_n) begin
        PC_current <= 0;
    end
    else begin
        if(en) begin
            PC_current <= PC;
        end
    end
end

endmodule