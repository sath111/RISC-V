module EXTEND(
	input [1:0] Imm,
	input [24:0] data_in,
	output reg [31:0] data_out
);

	always @(*) begin
		case(Imm) 
			2'b00: data_out = {{20{data_in[24]}}, data_in[24:13]}; //I
			2'b01: data_out = {{20{data_in[24]}}, data_in[24:18], data_in[4:0]}; //S
			2'b10: data_out = {{20{data_in[24]}}, data_in[0], data_in[23:18], data_in[4:1], 1'b0}; //B
			2'b11: data_out = {{27{1'b0}}, data_in[17:13]}; //shift
			default: data_out = 32'd0;
		endcase 
end
endmodule