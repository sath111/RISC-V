`include "ADD.v"
`include "ALU.v"
`include "CONTROL.v"
`include "DMEM.v"
`include "EXTEND.v"
`include "IMEM.v"
`include "MUX2.v"
`include "MUX2v1.v"
`include "PC.v"
`include "REGISTERFILE.v"


module RV32I #(
    parameter a_width = 8,
    parameter d_width = 32
)
(
    input clk, rst_n
);

wire en_PC, branch;
wire [a_width -1 : 0] PC_current, PC_branch, PC_next;

PC PC_inst(
    .clk(clk),
    .rst_n(rst_n),
    .en(en_PC),
    .PC_current(PC_next),
    .PC_branch(PC_branch),
    .PC_next(PC_next)
);

wire [d_width -1 : 0] ins;
IMEM IMEM_inst(
    .addr(PC_next),
    .rdata(ins)
);

wire zero;
wire src_rf;
wire wen_rf;
wire [1:0] Imm;
wire alu_src;
wire [3:0] ALU_control;
wire en_dmem;
wire load_store;
wire [2:0] funct3_dmem;
wire writeback;

CONTROL CONTROL_inst(
    .opcode(ins[6:0]),
    .funct3(ins[14:12]),
    .funct7(ins[31:25]),
    .zero(zero),
    .en_PC(en_PC),
    .branch(branch),
    .src_rf(src_rf),
    .wen_rf(wen_rf),
    .Imm(Imm),
    .alu_src(alu_src),
    .ALU_control(ALU_control),
    .en_dmem(en_dmem),
    .load_store(load_store),
    .funct3_dmem(funct3_dmem),
    .writeback(writeback)
);

wire [d_width -1 : 0] writeback_data, wb_data_rf;
MUX2 MUX2_ins0(
    .ins(ins[31:12]),
    .wb_data(writeback_data),
    .src_rf(src_rf),
    .wb_data_rf(wb_data_rf)
);

wire [d_width -1 : 0] out_rf1, out_rf2;
REGISTERFILE REGISTERFILE_inst(
    .clk(clk),
    .rst_n(rst_n),
    .wen(wen_rf),
    .raddr1(ins[19:15]),
    .raddr2(ins[24:20]),
    .waddr(ins[11:7]),
    .wdata(wb_data_rf),
    .rdata1(out_rf1),
    .rdata2(out_rf2)
);

wire [d_width -1 : 0] out_extend;
EXTEND EXTEND_inst(
    .Imm(Imm),
    .data_in(ins[31:7]),
    .data_out(out_extend)
);

wire [d_width -1 : 0] out_alu_src;
MUX2v1 MUX2v1_inst1(
    .a(out_rf2),
    .b(out_extend),
    .select(alu_src),
    .y(out_alu_src)
);

wire [d_width -1 : 0] alu_result;
ALU ALU_inst(
    .operator(ALU_control),
    .a(out_rf1),
    .b(out_extend),
    .c(alu_result),
    .zero(zero)
);

wire [d_width -1 : 0] dmem_result;
DMEM DMEM_inst(
    .clk(clk),
    .rst_n(rst_n),
    .cs(en_dmem),
    .load_store(load_store),
    .funct3(funct3_dmem),
    .addr(alu_result[7:0]),
    .wdata(out_rf2),
    .rdata(dmem_result)
);

MUX2v1 MUXv1_inst2(
    .a(alu_result),
    .b(dmem_result),
    .select(writeback),
    .y(writeback_data)
);

ADD ADD_inst(
    .PC_next(PC_next),
    .out_extend(out_extend),
    .PC_branch(PC_branch)
);

endmodule