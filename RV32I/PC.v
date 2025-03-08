module PC #(
	parameter d_width = 32
)
(
	input clk, rst_n,
	input PC_Src,
	input [d_width - 1 : 0] IMM,
	output reg [d_width - 1 : 0] PC_Addr
);

	reg [d_width -1 : 0] PC_Next;
	
	always @(*) begin
		PC_Next = (PC_Src == 0) ? PC_Addr + 32'd4 : PC_Addr + IMM;
	end
	
	always @(posedge clk) begin
		if(~rst_n) PC_Addr <= 32'd0;
		else PC_Addr <= PC_Next;
	end
	
endmodule
