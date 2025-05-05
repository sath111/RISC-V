module ADD_PCv1(
    input [7:0] PC_currentF,
    output [7:0] PC_nextF
);

assign PC_nextF = (PC_currentF + 3'd4);

endmodule