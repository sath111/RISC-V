module MUX2v2 #(
    parameter d_width = 32
)
(
    input [d_width -1 :0] a,
    input [d_width -1 :0] b,
    input select,
    output [d_width -1 :0] y
);

assign y = (select) ? b : a; 
endmodule