module IMEM #(
    parameter d_width = 32,
    parameter a_width = 8
)
(
    input [a_width -1 : 0] addr,
    output reg [d_width -1 : 0] rdata
);

reg [d_width -1 : 0] mem [0 : ((1 << a_width) -1)];

initial begin
    $readmemb("E:/HDL/RV32IN/code.txt", mem);
end

always @(*) begin
    rdata = mem[addr >> 2];
end

endmodule