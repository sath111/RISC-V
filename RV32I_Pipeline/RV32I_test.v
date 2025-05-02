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
    .PC_nextF(PC_nextF)
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



endmodule