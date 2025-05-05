module ADD_PC(
    input [7:0] PC_currentF,
    output [7:0] PC_nextF,
    input rst_n
);

assign PC_nextF = (rst_n) ? (PC_currentF + 3'd4) : 0;

endmodule