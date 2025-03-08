module IMEM #(
	parameter d_width = 32,
	parameter a_width = 32
)
(
	input [a_width -1 : 0] addr,
	output [d_width -1: 0] data_out_mem
);

reg [31:0] mem [0:255];

initial begin 
	$readmemb("code.txt", mem);
	end
	
	assign data_out_mem = mem[addr/4];
endmodule