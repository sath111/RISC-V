module ADDv1(
    input [7:0] PC_current,
    input [31:0] out_extend,
    output [7:0] PC_branch
);

assign PC_branch = PC_current + out_extend[7:0];

endmodule