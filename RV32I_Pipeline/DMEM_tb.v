`timescale 1ps/1ps
`include "DMEM.v"

module DMEM_tb;

parameter d_width = 8;
parameter a_width = 8;

reg clk, rst_n;
reg cs;
reg wen_ren;
reg [a_width -1 : 0] addr;
reg [d_width -1 : 0] wdata;
wire [d_width -1 : 0] rdata;

DMEM #(
    .d_width(d_width),
    .a_width(a_width)
)
uut(
    .clk(clk),
    .rst_n(rst_n),
    .cs(cs),
    .wen_ren(wen_ren),
    .addr(addr),
    .wdata(wdata),
    .rdata(rdata)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("DMEM_tb.vcd");
    $dumpvars(0, DMEM_tb);

    clk = 0;
    rst_n = 1;
    cs = 0;
    wen_ren = 0;
    addr = 0;
    wdata = 0;

    #10 rst_n = 0;
    #10 rst_n = 1;

    #10 
    cs = 1;
    wen_ren = 1;
    addr = 3;
    wdata = 30;

    #10
    addr = 4;
    wdata = 40;

    #10
    addr = 5;
    wdata = 50;

    #10
    cs = 0;
    wen_ren = 0;

    #10 
    cs = 1;
    wen_ren = 0;
    addr = 5;

    #10
    addr = 4;

    #10 
    addr = 3;

    #10
    $finish;
end

endmodule