module REGISTERFILE #(
	parameter d_width = 32,
	parameter a_width = 5
)
(
	input clk, rst_n,
	input wen,
	input [a_width -1 : 0] raddr1, raddr2,
	input [a_width -1 : 0] waddr,
	input [d_width -1 : 0] wdata,
	
	output [d_width -1 : 0] rdata1,
	output [d_width -1 : 0] rdata2
);

reg [d_width -1 : 0] mem [0 : ((1 << a_width) -1 )];
integer i;
always @(posedge clk, negedge rst_n) begin
	if(!rst_n) begin
		for(i = 0; i < (1 << a_width); i = i + 1) begin
			mem[i] <= 32'd0;
		end
	end
	else begin
		if(wen) begin
			mem[waddr] <= wdata;
		end
	end
end

assign rdata1 = mem[raddr1];
assign rdata2 = mem[raddr2];

endmodule