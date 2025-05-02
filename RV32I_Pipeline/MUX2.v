module MUX2(
    input [19:0] ins,
    input [31:0] wb_data,
    input src_rf,
    output [31:0] wb_data_rf 
);

wire [31:0] a;
assign a = {{12{ins[19]}}, ins};

assign wb_data_rf = (src_rf) ? wb_data : a;

endmodule