module ADD(
    input [7:0] PC_current,
    input [31:0] out_extend,
    output [7:0] PC_branch,
    input rst_n
);

assign PC_branch = (rst_n) ? PC_current + out_extend[7:0] : 0;

endmodule