module EX_ME(
    input clk, rst_n,
    input [1:0] writebackE, 
    input [2:0] funcE,
    input load_storeE,
    input en_dmemE,
    input wen_rfE,
    input [31:0] alu_resultE,
    input [31:0] out_rf2E1,
    input [4:0] rdE,
    input [7:0] PC_nextE,

    output reg [1:0] writebackM,
    output reg [2:0] funcM,
    output reg load_storeM,
    output reg en_dmemM,
    output reg wen_rfM,
    output reg [31:0] alu_resultM,
    output reg [31:0] out_rf2M,
    output reg [4:0] rdM,
    output reg [7:0] PC_nextM
);

always@(posedge clk) begin
    if(~rst_n) begin
        writebackM <= 0;
        funcM <= 0;
        load_storeM <= 0;
        en_dmemM <= 0;
        wen_rfM <= 0;
        alu_resultM <= 0;
        out_rf2M <= 0;
        rdM <= 0;
        PC_nextM <= 0;
    end
    else begin
        writebackM <= writebackE;
        funcM <= funcE;
        load_storeM <= load_storeE;
        en_dmemM <= en_dmemE;
        wen_rfM <= wen_rfE;
        alu_resultM <= alu_resultE;
        out_rf2M <= out_rf2E1;
        rdM <= rdE;
        PC_nextM <= PC_nextE;
    end
    
end

endmodule