module datapath#(
	parameter d_width = 32,
	parameter a_width = 32
)
(
	input PC_Src,
	input Reg_Write,
	input [1:0] IMM_Src,
	input ALU_Src,
	input [3:0] ALU_Control,
	input MEM_Write,
	input Result_Src,
	input clk, rst_n,
	
	output Zero_Flag,
	output [6:0] opcode,
	output [2:0] funct3,
	output [6:0] funct7
);



	wire [d_width -1 : 0] PC_Addr;
	wire [d_width -1 : 0] i_mem;
	wire [d_width -1 : 0] data_result;
	wire [d_width -1 : 0] data_rf1, data_rf2;
	wire [d_width -1 : 0] data_out_extend;
	wire [d_width -1 : 0] data_alu_src;
	wire [d_width -1 : 0] data_alu_result;	
	wire [d_width -1 : 0] data_out_dmem;
	
	assign opcode = i_mem[6:0];
	assign funct3 = i_mem[14:12];
	assign funct7 = i_mem[31:25];
	
	assign out_rf1 = data_rf1;
	assign out_rf2 = data_rf2;
	
	PC PC_inst(.clk(clk),
				  .rst_n(rst_n),
				  .IMM(data_out_extend),
				  .PC_Addr(PC_Addr)
	);
	
	
	IMEM IMEM_inst(.addr(PC_Addr), .data_out_mem(i_mem));
	
	register_file register_file_inst(.data_in(data_result), 
												.w_addr(i_mem[11:7]), 
												.r_addr1(i_mem[19:15]), 
												.r_addr2(i_mem[24:20]),
												.clk(clk), 
												.rst_n(rst_n), 
												.we(Reg_Write),
												.data_out1(data_rf1),
												.data_out2(data_rf2)
												);
	
	Extend Ex_inst(.IMM_Src(IMM_Src),
						.data_in(i_mem[31:7]),
						.data_out(data_out_extend)
						
	);
	
	mux2 mux2_inst(.sel(ALU_Src),
						.data1(data_rf2),
						.data2(data_out_extend),
						.data_out(data_alu_src)
	);
	
	ALU ALU_inst(.a(data_rf1),
					 .b(data_alu_src),
					 .opcode(ALU_Control),
					 .out_alu(data_alu_result),
					 .zero_flag(Zero_Flag)
	);
	
	DMEM DMEM_inst(.data_in(data_rf2),
						.addr(data_alu_result),
						.clk(clk),
						.rst_n(rst_n),
						.we(MEM_Write),
						.data_out(data_out_dmem)
	);
	
	mux2 mux2_inst1(.sel(Result_Src),
						 .data1(data_alu_result),
						 .data2(data_out_dmem),
						 .data_out(data_result)
	);
												
endmodule				