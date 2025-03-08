module top#(parameter d_width = 32)(
	input clk, rst_n
	
);

wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;

wire PC_Src, Reg_Wr, ALU_Src, MEM_Wr, Result_Src;
wire [1:0] IMM_Src;
wire [4:0] ALU_Control;
wire Zero_Flag;


datapath datapath_inst(.PC_Src(PC_Src),
							  .Reg_Write(Reg_Wr),
							  .IMM_Src(IMM_Src),
							  .ALU_Src(ALU_Src),
							  .ALU_Control(ALU_Control),
							  .MEM_Write(MEM_Wr),
							  .Result_Src(Result_Src),
							  .clk(clk),
							  .rst_n(rst_n),
							  .Zero_Flag(Zero_Flag),
							  .opcode(opcode),
							  .funct3(funct3),
							  .funct7(funct7)
);

controller controller_inst(.opcode(opcode),
									.funct3(funct3),
									.funct7(funct7),
									.PC_Src(PC_Src),
									.Reg_Wr(Reg_Wr),
									.IMM_Src(IMM_Src),
									.ALU_Src(ALU_Src),
									.ALU_Control(ALU_Control),
									.MEM_Wr(MEM_Wr),
									.Result_Src(Result_Src),
);

endmodule