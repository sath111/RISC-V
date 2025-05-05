module ME_WB(
    input clk, rst_n,
    input [1:0] writebackM,
    input wen_rfM,
    input [31:0] alu_resultM,
    input [31:0] dmem_resultM,
    input [4:0] rdM,
    input [7:0] PC_nextM,

    output reg [1:0] writebackW,
    output reg wen_rfW,
    output reg [31:0] alu_resultW,
    output reg [31:0] dmem_resultW,
    output reg [4:0] rdW,
    output reg [7:0] PC_nextW
);

always@(posedge clk) begin
    if(~rst_n) begin
        writebackW <= 0;
        wen_rfW <= 0;
        alu_resultW <= 0;
        dmem_resultW <= 0;
        rdW <= 0;
        PC_nextW <= 0;
    end
    else begin
        writebackW <= writebackM;
        wen_rfW <= wen_rfM;
        alu_resultW <= alu_resultM;
        dmem_resultW <= dmem_resultM;
        rdW <= rdM;
        PC_nextW <= PC_nextM;
    end
    
end

endmodule