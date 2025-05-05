`include "IMEM.v"
`timescale 1ps/1ps

module IMEM_tb;

reg [1:0] addr;
wire [31:0] rdata;

IMEM dut(
    .addr(addr),
    .rdata(rdata)
);

initial begin
    $dumpfile("IMEM_tb.vcd");
    $dumpvars(0, IMEM_tb);

    #10;
    addr = 0;
    #10;
    addr = 1;
    #10;
    addr = 2;
    #10;
    $finish;
end

endmodule