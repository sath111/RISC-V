module ID_EX(
    input clk, rst_n,
    input jumpD,
    input branchD,
    input [1:0] writebackD,
    input [2:0] funcD,
    input load_storeD,
    input en_dmemD,
    input [3:0] ALU_controlD,
    input alu_srcD,
    input wen_rfD,
    input [31:0] out_rf1D,
    input [31:0] out_rf2D,
    input [31:0] out_extendD,
    input [4:0] rdD,
    input [7:0] PC_currentD,
    input [7:0] PC_nextD,
    input [4:0] rs1D,
    input [4:0] rs2D,


    output reg jumpE,
    output reg branchE,
    output reg [1:0] writebackE,
    output reg [2:0] funcE,
    output reg load_storeE,
    output reg en_dmemE,
    output reg [3:0] ALU_controlE,
    output reg alu_srcE,
    output reg wen_rfE,
    output reg [31:0] out_rf1E,
    output reg [31:0] out_rf2E,
    output reg [31:0] out_extendE,
    output reg [4:0] rdE,
    output reg [7:0] PC_currentE,
    output reg [7:0] PC_nextE,
    output reg [4:0] rs1E,
    output reg [4:0] rs2E
);

always @(posedge clk) begin
    if(~rst_n) begin
        jumpE <= 0;
        branchE <= 0;
        writebackE <= 0;
        funcE <= 0;
        load_storeE <= 0;
        en_dmemE <= 0;
        ALU_controlE <= 0;
        alu_srcE <= 0;
        wen_rfE <= 0;
        out_rf1E <= 0;
        out_rf2E <= 0;
        out_extendE <= 0;
        rdE <= 0;
        PC_currentE <= 0;
        PC_nextE <= 0;
        rs1E <= 0;
        rs2E <= 0;
    end
    else begin
        jumpE <= jumpD;
        branchE <= branchD;
        writebackE <= writebackD;
        funcE <= funcD;
        load_storeE <= load_storeD;
        en_dmemE <= en_dmemD;
        ALU_controlE <= ALU_controlD;
        alu_srcE <= alu_srcD;
        wen_rfE <= wen_rfD;
        out_rf1E <= out_rf1D;
        out_rf2E <= out_rf2D;
        out_extendE <= out_extendD;
        rdE <= rdD;
        PC_currentE <= PC_currentD;
        PC_nextE <= PC_nextD;
        rs1E <= rs1D;
        rs2E <= rs2D;
    end
end

endmodule