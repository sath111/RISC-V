module DMEM #(
	parameter d_width = 32,
	parameter a_width = 32
)
(	
	input [d_width -1 : 0] data_in,
	input [a_width -1 : 0] addr,
	input clk, rst_n, we,
	
	output [d_width -1 : 0] data_out
);

reg [31:0] mem [0:31];
integer i;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			for(i = 0; i < 32; i = i + 1) begin
				mem[i] <= 32'd0;
			end
		end
		else 
			if(we) mem[addr] <= data_in;
	end
	
	assign data_out = mem[addr];
endmodule