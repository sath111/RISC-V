`timescale 1ps/1ps
`include "REGISTERFILE.v"

module REGISTERFILE_tb;

parameter d_width = 32;
parameter a_width = 5;

reg clk, rst_n;
reg wen;
reg [a_width -1 : 0] raddr1, raddr2;
reg [a_width -1 : 0] waddr;
reg [d_width -1 : 0] wdata;
	
wire [d_width -1 : 0] rdata1;
wire [d_width -1 : 0] rdata2;

REGISTERFILE #(
    .d_width(d_width),
    .a_width(a_width)
)
dut(
    .clk(clk),
    .rst_n(rst_n),
    .wen(wen),
    .raddr1(raddr1),
    .raddr2(raddr2),
    .waddr(waddr),
    .wdata(wdata),
    .rdata1(rdata1),
    .rdata2(rdata2)
);

always #5 clk = ~clk;

initial begin

    $dumpfile("REGISTERFILE_tb.vcd");
    $dumpvars(0, REGISTERFILE_tb);

    clk = 0;
    rst_n = 1;
    raddr1 = 0;
    raddr2 = 0;
    waddr = 0;
    wen = 0;
    wdata = 0;

    #10 rst_n = 0;
    #10 rst_n = 1;

    #10

    wen = 1;
    waddr = 1;
    wdata = 10;

    #10
    waddr = 2;
    wdata = 20;

    #10
    waddr = 20;
    wdata = 40;

    #10
    wen = 0;

    #10     
    raddr1 = 1;
    raddr2 = 2;
    
    #10
    raddr1 = 20;
    #10;

    $finish;
end

endmodule