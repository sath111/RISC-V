module Extend(
	input [1:0] IMM_Src,
	input [24:0] data_in,
	output reg [31:0] data_out
);

	always @(*) begin
		case(IMM_Src) 
			2'b00: data_out = {{20{data_in[24]}}, data_in[24:13]};
			2'b01: data_out = {{20{data_in[24]}}, data_in[24:18], data_in[4:0]};
			2'b10: data_out = {{20{data_in[24]}}, data_in[0], data_in[23:18], data_in[4:1], 1'b0};
			default: data_out = 32'd0;
		endcase 
end
endmodule
