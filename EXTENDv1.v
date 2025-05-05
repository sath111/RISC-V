module EXTENDv1(
	input [2:0] Imm,
	input [24:0] data_in,
	output reg [31:0] data_out
);

	always @(*) begin
		case(Imm) 
			3'b000: data_out = {{20{data_in[24]}}, data_in[24:13]}; //I
			3'b001: data_out = {{20{data_in[24]}}, data_in[24:18], data_in[4:0]}; //S
			3'b010: data_out = {{20{data_in[24]}}, data_in[0], data_in[23:18], data_in[4:1], 1'b0}; //B
			3'b011: data_out = {{27{1'b0}}, data_in[17:13]}; //shift
			3'b100: data_out = {{12{data_in[24]}}, data_in[12:5], data_in[23:13], 1'b0}; //j
			3'b101: data_out = {{13{data_in[24]}}, data_in[24:5]}; //lui
			default: data_out = 32'd0;
		endcase 
	end
endmodule