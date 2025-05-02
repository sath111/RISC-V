`timescale 1ps/1ps
`include "HAZARD_UNIT.v"

module tb_HAZARD_UNIT;

    // Inputs
    reg [4:0] rs1D, rs2D;
    reg [4:0] rs1E, rs2E;
    reg [4:0] rdM, rdW, rdE;
    reg [1:0] writebackE;
    reg wen_rfM, wen_rfW;
    reg en_branch;

    // Outputs
    wire [1:0] fw_AE, fw_BE;
    wire STALLPCF, STALLD, FLUSHD, FLUSHE;

    // Instantiate the Unit Under Test (UUT)
    HAZARD_UNIT uut (
        .rs1D(rs1D), .rs2D(rs2D),
        .rs1E(rs1E), .rs2E(rs2E),
        .rdM(rdM), .rdW(rdW), .rdE(rdE),
        .writebackE(writebackE),
        .wen_rfM(wen_rfM), .wen_rfW(wen_rfW),
        .en_branch(en_branch),
        .fw_AE(fw_AE), .fw_BE(fw_BE),
        .STALLPCF(STALLPCF), .STALLD(STALLD),
        .FLUSHD(FLUSHD), .FLUSHE(FLUSHE)
    );

    initial begin
        $display("Time\tfw_AE fw_BE STALLPCF STALLD FLUSHD FLUSHE");
        $monitor("%g\t%b     %b     %b        %b     %b      %b",
            $time, fw_AE, fw_BE, STALLPCF, STALLD, FLUSHD, FLUSHE);

        // Khởi tạo
        rs1D = 0; rs2D = 0;
        rs1E = 0; rs2E = 0;
        rdM  = 0; rdW  = 0; rdE  = 0;
        writebackE = 2'b00;
        wen_rfM = 0; wen_rfW = 0;
        en_branch = 0;
        #10;

        // Case 1: Forwarding từ MEM
        rs1E = 5'd10;
        rdM  = 5'd10;
        wen_rfM = 1;
        #10;

        // Case 2: Forwarding từ WB
        rs2E = 5'd20;
        rdW  = 5'd20;
        wen_rfW = 1;
        #10;

        // Case 3: Stall do phụ thuộc load-use (rdE == rs1D)
        rs1D = 5'd5;
        rdE  = 5'd5;
        writebackE = 2'b01; // load instruction
        #10;

        // Case 4: Branch - flush D stage
        en_branch = 1;
        #10;

        // Reset các giá trị về bình thường
        wen_rfM = 0;
        wen_rfW = 0;
        writebackE = 2'b00;
        en_branch = 0;
        #10;

        $finish;
    end

endmodule
