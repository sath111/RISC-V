module registerfile_test #(
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
	output [d_width -1 : 0] rdata2,

    output [d_width -1 : 0] r0,
    output [d_width -1 : 0] r1,
    output [d_width -1 : 0] r2,
    output [d_width -1 : 0] r3,
    output [d_width -1 : 0] r4,
    output [d_width -1 : 0] r5,
    output [d_width -1 : 0] r6,
    output [d_width -1 : 0] r7,
    output [d_width -1 : 0] r8,
    output [d_width -1 : 0] r9,
    output [d_width -1 : 0] r10,
    output [d_width -1 : 0] r11,
    output [d_width -1 : 0] r12,
    output [d_width -1 : 0] r13,
    output [d_width -1 : 0] r14,
    output [d_width -1 : 0] r15,
    output [d_width -1 : 0] r16,
    output [d_width -1 : 0] r17,
    output [d_width -1 : 0] r18,
    output [d_width -1 : 0] r19,
    output [d_width -1 : 0] r20,
    output [d_width -1 : 0] r21,
    output [d_width -1 : 0] r22,
    output [d_width -1 : 0] r23,
    output [d_width -1 : 0] r24,
    output [d_width -1 : 0] r25,
    output [d_width -1 : 0] r26,
    output [d_width -1 : 0] r27,
    output [d_width -1 : 0] r28,
    output [d_width -1 : 0] r29,
    output [d_width -1 : 0] r30,
    output [d_width -1 : 0] r31
);

reg [d_width -1 : 0] mem [0 : ((1 << a_width) -1 )];
integer i;
always @(negedge clk, negedge rst_n) begin
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

assign r0 = mem[0];
assign r1 = mem[1];
assign r2 = mem[2];
assign r3 = mem[3];
assign r4 = mem[4];
assign r5 = mem[5];
assign r6 = mem[6];
assign r7 = mem[7];

assign r8 = mem[8];
assign r9 = mem[9];
assign r10 = mem[10];
assign r11 = mem[11];
assign r12 = mem[12];
assign r13 = mem[13];
assign r14 = mem[14];
assign r15 = mem[15];

assign r16 = mem[16];
assign r17 = mem[17];
assign r18 = mem[18];
assign r19 = mem[19];
assign r20 = mem[20];
assign r21 = mem[21];
assign r22 = mem[22];
assign r23 = mem[23];

assign r24 = mem[24];
assign r25 = mem[25];
assign r26 = mem[26];
assign r27 = mem[27];
assign r28 = mem[28];
assign r29 = mem[29];
assign r30 = mem[30];
assign r31 = mem[31];
endmodule