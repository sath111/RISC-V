module mux2 #(
	parameter d_width = 32
)
(
	input [d_width -1 : 0] data1,
	input [d_width -1 : 0] data2,
	input sel,
	
	output reg [d_width -1: 0] data_out
);

	always @(*) begin
		case(sel) 
			1'b0: data_out = data1;
			1'b1: data_out = data2;
		endcase
	end
endmodule