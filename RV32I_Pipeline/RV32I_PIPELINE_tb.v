`timescale 1ns / 1ps
`include "RV32I_PIPELINE.v"
module RV32I_PIPELINE_tb;

    parameter d_width = 32;

    reg clk;
    reg rst_n;
    wire zero;
    wire [d_width-1:0] r0, r1, r2, r3, r4, r5, r6, r7;
    wire [d_width-1:0] r8, r9, r10, r11, r12, r13, r14, r15;
    wire [d_width-1:0] r16, r17, r18, r19, r20, r21, r22, r23;
    wire [d_width-1:0] r24, r25, r26, r27, r28, r29, r30, r31;

    // Instantiate DUT
    RV32I_PIPELINE #(d_width) dut (
        .clk(clk),
        .rst_n(rst_n),
        .zero(zero),
        .r0(r0), .r1(r1), .r2(r2), .r3(r3), .r4(r4), .r5(r5), .r6(r6), .r7(r7),
        .r8(r8), .r9(r9), .r10(r10), .r11(r11), .r12(r12), .r13(r13), .r14(r14), .r15(r15),
        .r16(r16), .r17(r17), .r18(r18), .r19(r19), .r20(r20), .r21(r21), .r22(r22), .r23(r23),
        .r24(r24), .r25(r25), .r26(r26), .r27(r27), .r28(r28), .r29(r29), .r30(r30), .r31(r31)
    );

    // Clock generator
    always #5 clk = ~clk;  // 10ns period → 100MHz

    initial begin
        // Initial state
        $dumpfile("RV32I_PIPELINE_tb.vcd");
        $dumpvars(0, RV32I_PIPELINE_tb);
        clk = 0;
        rst_n = 0;

        // Hold reset for a while
        #30;
        rst_n = 1;


        // Wait some cycles
        #200;
        #10;
        $finish;
    end

endmodule
