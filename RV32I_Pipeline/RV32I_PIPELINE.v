`include "MUX2v2.v"
`include "MUX2.v"
`include "PCv1.v"
`include "IMEM.v"
`include "ADD_PC.v"
`include "IF_ID.v"
`include "CONTROL_PIPELINE.v"
`include "registerfile_test.v"
`include "EXTENDv1.v"
`include "ID_EX.v"
`include "MUX41.v"
`include "ALU.v"
`include "ADD.v"
`include "EX_ME.v"
`include "DMEM.v"
`include "ME_WB.v"
`include "HAZARD_UNIT.v"

module RV32I_PIPELINE #(
    parameter d_width = 32
)
(
    input clk, rst_n,
    output zero,
    output [d_width -1 : 0] r0,
    output [d_width -1 : 0] r1,
    output [d_width -1 : 0] r2,
    output [d_width -1 : 0] r3,
    output [d_width -1 : 0] r4,
    output [d_width -1 : 0] r5,
    output [d_width -1 : 0] r6,
    output [d_width -1 : 0] r7,
    output [d_width -1 : 0] r8,
    output [d_width -1 : 0] r9,
    output [d_width -1 : 0] r10,
    output [d_width -1 : 0] r11,
    output [d_width -1 : 0] r12,
    output [d_width -1 : 0] r13,
    output [d_width -1 : 0] r14,
    output [d_width -1 : 0] r15,
    output [d_width -1 : 0] r16,
    output [d_width -1 : 0] r17,
    output [d_width -1 : 0] r18,
    output [d_width -1 : 0] r19,
    output [d_width -1 : 0] r20,
    output [d_width -1 : 0] r21,
    output [d_width -1 : 0] r22,
    output [d_width -1 : 0] r23,
    output [d_width -1 : 0] r24,
    output [d_width -1 : 0] r25,
    output [d_width -1 : 0] r26,
    output [d_width -1 : 0] r27,
    output [d_width -1 : 0] r28,
    output [d_width -1 : 0] r29,
    output [d_width -1 : 0] r30,
    output [d_width -1 : 0] r31
);


//IF
wire [7:0] PC_nextF, PC_branchF, PC_currentF, PC_currentF0;
wire en_branch;
MUX2v2#(
    .d_width(8)
)
MUX2v2_inst0(
    .a(PC_nextF),
    .b(PC_branchF),
    .select(en_branch),
    .y(PC_currentF0)
);
wire STALLPCF;
PCv1 PCv1_inst(
    .clk(clk),
    .rst_n(rst_n),
    .en(STALLPCF),
    .PC(PC_currentF0),
    .PC_current(PC_currentF)
);

wire [31:0] insF;
IMEM IMEM_inst(
    .addr(PC_currentF),
    .rdata(insF)
);
ADD_PC ADD_PC_inst(
    .PC_currentF(PC_currentF),
    .PC_nextF(PC_nextF),
    .rst_n(rst_n)
);

wire [31:0] insD;
wire [7:0] PC_currentD, PC_nextD;
wire STALLD, FLUSHD;
IF_ID IF_ID_inst(
    .clk(clk),
    .rst_n(FLUSHD),
    .enIF_ID(STALLD),
    .insF(insF),
    .PC_currentF(PC_currentF),
    .PC_nextF(PC_nextF),
    .insD(insD),
    .PC_currentD(PC_currentD),
    .PC_nextD(PC_nextD)
);

//ID
wire jumpD, branchD;
wire [1:0] writebackD;
wire [2:0] funcD;
wire load_storeD;
wire en_dmemD;
wire [3:0] ALU_controlD;
wire alu_srcD;
wire wen_rfD;
wire [2:0] ImmD;
wire src_rfD;
wire [31:0] out_rf1D, out_rf2D, out_extendD;
CONTROL_PIPELINE CONTROL_PIPELINE_inst(
    .opcode(insD[6:0]),
    .funct3(insD[14:12]),
    .funct7(insD[31:25]),
    .jum(jumpD),
    .branch(branchD),
    .wen_rf(wen_rfD),
    .Imm(ImmD),
    .alu_src(alu_srcD),
    .ALU_control(ALU_controlD),
    .en_dmem(en_dmemD),
    .load_store(load_storeD),
    .funct3_dmem(funcD),
    .writeback(writebackD)
);
wire en_rfW;
wire [4:0] rdW;
wire [31:0] out_writeback_result;
wire [31:0] wb_data_rf;


registerfile_test registerfile_test_inst(
    .clk(clk),
    .rst_n(rst_n),
    .wen(en_rfW),
    .raddr1(insD[19:15]),
    .raddr2(insD[24:20]),
    .waddr(rdW),
    .wdata(out_writeback_result),
    .rdata1(out_rf1D),
    .rdata2(out_rf2D),

    .r0(r0),
    .r1(r1),
    .r2(r2),
    .r3(r3),
    .r4(r4),
    .r5(r5),
    .r6(r6),
    .r7(r7),
    .r8(r8),
    .r9(r9),
    .r10(r10),
    .r11(r11),
    .r12(r12),
    .r13(r13),
    .r14(r14),
    .r15(r15),
    .r16(r16),
    .r17(r17),
    .r18(r18),
    .r19(r19),
    .r20(r20),
    .r21(r21),
    .r22(r22),
    .r23(r23),
    .r24(r24),
    .r25(r25),
    .r26(r26),
    .r27(r27),
    .r28(r28),
    .r29(r29),
    .r30(r30),
    .r31(r31)
);
//wire zero;

assign en_branch = ((branchE & zero) | jumpE);

EXTENDv1 EXTENDv1_inst(
    .Imm(ImmD),
    .data_in(insD[31:7]),
    .data_out(out_extendD)
);

wire jumpE;
wire branchE;
wire [1:0] writebackE;
wire [2:0] funcE;
wire load_storeE;
wire en_dmemE;
wire [3:0] ALU_controlE;
wire alu_srcE;
wire wen_rfE;
wire [31:0] out_rf1E;
wire [31:0] out_rf2E;
wire [31:0] out_extendE;
wire [4:0] rdE;
wire [7:0] PC_currentE;
wire [7:0] PC_nextE;
wire [4:0] rs1E;
wire [4:0] rs2E;
wire FLUSHE;
ID_EX ID_EX_inst(
    .clk(clk),
    .rst_n(FLUSHE),
    .jumpD(jumpD),
    .branchD(branchD),
    .writebackD(writebackD),
    .funcD(funcD),
    .load_storeD(load_storeD),
    .en_dmemD(en_dmemD),
    .ALU_controlD(ALU_controlD),
    .alu_srcD(alu_srcD),
    .wen_rfD(wen_rfD),
    .out_rf1D(out_rf1D),
    .out_rf2D(out_rf2D),
    .out_extendD(out_extendD),
    .rdD(insD[11:7]),
    .PC_currentD(PC_currentD),
    .PC_nextD(PC_nextD),
    .rs1D(insD[19:15]),
    .rs2D(insD[24:20]),

    .jumpE(jumpE),
    .branchE(branchE),
    .writebackE(writebackE),
    .funcE(funcE),
    .load_storeE(load_storeE),
    .en_dmemE(en_dmemE),
    .ALU_controlE(ALU_controlE),
    .alu_srcE(alu_srcE),
    .wen_rfE(wen_rfE),
    .out_rf1E(out_rf1E),
    .out_rf2E(out_rf2E),
    .out_extendE(out_extendE),
    .rdE(rdE),
    .PC_currentE(PC_currentE),
    .PC_nextE(PC_nextE),
    .rs1E(rs1E),
    .rs2E(rs2E)
);

//EX


wire [31:0] alu_resultM, alu_resultE;
wire [1:0] fw_AE, fw_BE;
wire [31:0] src_AE, srcBE_tmp, srcBE;
MUX41 MUX41_inst0(
    .select(fw_AE),
    .a(out_rf1E),
    .b(alu_resultM),
    .c(out_writeback_result),
    .d(32'd0),
    .y(src_AE)
);
MUX41 MUX41_inst1(
    .select(fw_BE),
    .a(out_rf2E),
    .b(alu_resultM),
    .c(out_writeback_result),
    .d(32'd0),
    .y(srcBE_tmp)
);
MUX2v2 MUX2_inst1(
    .select(alu_srcE),
    .a(srcBE_tmp),
    .b(out_extendE),
    .y(srcBE)
);
ALU ALU_inst(
    .operator(ALU_controlE),
    .a(src_AE),
    .b(srcBE),
    .c(alu_resultE),
    .zero(zero),
    .rst_n(rst_n)
);
ADD ADD_inst(
    .PC_current(PC_currentE),
    .out_extend(out_extendE),
    .PC_branch(PC_branchF),
    .rst_n(rst_n)
);

wire [1:0] writebackM;
wire [2:0] funcM;
wire load_storeM;
wire en_dmemM;
wire wen_rfM;
wire [31:0] src_BM;
wire [4:0] rdM;
wire [7:0] PC_nextM;

EX_ME EX_ME_inst(
    .clk(clk),
    .rst_n(rst_n),
    .writebackE(writebackE),
    .funcE(funcE),
    .load_storeE(load_storeE),
    .en_dmemE(en_dmemE),
    .wen_rfE(wen_rfE),
    .alu_resultE(alu_resultE),
    .out_rf2E1(srcBE_tmp),
    .rdE(rdE),
    .PC_nextE(PC_nextE),

    .writebackM(writebackM),
    .funcM(funcM),
    .load_storeM(load_storeM),
    .en_dmemM(en_dmemM),
    .wen_rfM(wen_rfM),
    .alu_resultM(alu_resultM),
    .out_rf2M(src_BM),
    .rdM(rdM),
    .PC_nextM(PC_nextM)
);

//ME

wire [31:0] dmem_resultM;
DMEM DMEM_inst(
    .clk(clk),
    .rst_n(rst_n),
    .cs(en_dmemM),
    .load_store(load_storeM),
    .funct3(funcM),
    .addr(alu_resultM[7:0]),
    .wdata(src_BM),
    .rdata(dmem_resultM)
);

wire [7:0] PC_nextW;

wire [1:0] writebackW;
wire [31:0] alu_resultW, dmem_resultW;

ME_WB ME_WB_inst(
    .clk(clk),
    .rst_n(rst_n),
    .writebackM(writebackM),
    .wen_rfM(wen_rfM),
    .alu_resultM(alu_resultM),
    .dmem_resultM(dmem_resultM),
    .rdM(rdM),
    .PC_nextM(PC_nextM),

    .writebackW(writebackW),
    .wen_rfW(en_rfW),
    .alu_resultW(alu_resultW),
    .dmem_resultW(dmem_resultW),
    .rdW(rdW),
    .PC_nextW(PC_nextW)
);

//WB
MUX41 MUX2_inst2(
    .select(writebackW),
    .a(alu_resultW),
    .b(dmem_resultW),
    .c({{24{1'b0}},PC_nextW}),
    .d(32'd0),
    .y(out_writeback_result)
);

HAZARD_UNIT HAZARD_UNIT_inst(
    .rs1D(insD[19:15]),
    .rs2D(insD[24:20]),
    .rs1E(rs1E),
    .rs2E(rs2E),
    .rdM(rdM),
    .rdW(rdW),
    .rdE(rdE),
    .writebackE(writebackE),
    .wen_rfM(wen_rfM),
    .wen_rfW(en_rfW),
    .en_branch(en_branch),
    .fw_AE(fw_AE),
    .fw_BE(fw_BE),
    .STALLPCF(STALLPCF),
    .STALLD(STALLD),
    .FLUSHD(FLUSHD),
    .FLUSHE(FLUSHE)
);


endmodule