module IF_ID(
    input clk, rst_n, enIF_ID,
    input [31:0] insF,
    input [7:0] PC_currentF,
    input [7:0] PC_nextF,

    output reg [31:0] insD,
    output reg [7:0] PC_currentD,
    output reg [7:0] PC_nextD
);

always @(posedge clk) begin
    if(~rst_n) begin
        insD <= 32'd0;
        PC_currentD <= 8'd0;
        PC_nextD <= 8'd0;
    end
    else begin
        if(enIF_ID) begin
            insD <= insF;
            PC_currentD <= PC_currentF;
            PC_nextD <= PC_nextF;
        end
    end
end
endmodule