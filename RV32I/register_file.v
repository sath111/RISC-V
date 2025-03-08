module register_file #(
	parameter d_width = 32,
	parameter a_width = 5
)
(	
	input [d_width -1 : 0] data_in,
	input [a_width -1 : 0] w_addr,
	input [a_width -1 : 0] r_addr1,
	input [a_width -1 : 0] r_addr2,
	input clk, we, rst_n,
	
	output [d_width -1 : 0] data_out1,
	output [d_width -1 : 0] data_out2
);

reg [d_width -1 : 0] mem [0 : 31];

integer i;

	always @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			for(i = 0; i < 32; i = i + 1) begin
				mem[i] <= 32'd0;
			end
		end
		else begin
			if(we && w_addr != 5'd0) mem[w_addr] <= data_in;
		end
	end
	
	assign data_out1 = mem[r_addr1];
	assign data_out2 = mem[r_addr2];
	
	endmodule