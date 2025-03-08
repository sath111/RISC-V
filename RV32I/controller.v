module controller(
	input [6:0] opcode,
	input [2:0] funct3,
	input [6:0] funct7,
	
	output reg PC_Src,
	output reg Reg_Wr,
	output reg [1:0] IMM_Src,
	output reg ALU_Src,
	output reg [3:0] ALU_Control,
	output reg MEM_Wr,
	output reg Result_Src
);

always@(*) begin
	case(opcode) 
		7'b0000011: begin							// lw
						PC_Src = 1'b0;
						Reg_Wr = 1'b1;
						IMM_Src = 2'b00;
						ALU_Src = 1'b1;
						MEM_Wr = 1'b0;
						Result_Src = 1'b1;
		end
		
		7'b0100011: begin 						//sw
						PC_Src = 1'b0;
						Reg_Wr = 1'b0;
						IMM_Src = 2'b01;
						ALU_Src = 1'b1;
						MEM_Wr = 1'b1;
						Result_Src = 1'bx;
		end
		
		7'b0110011: begin							// R
						PC_Src = 1'b0;
						Reg_Wr = 1'b1;
						IMM_Src = 2'bxx;
						ALU_Src = 1'b0;
						MEM_Wr = 1'b0;
						Result_Src = 1'b0;
		end
		
		7'b0010011: begin							// I
						PC_Src = 1'b0;
						Reg_Wr = 1'b1;
						IMM_Src = 2'b00;
						ALU_Src = 1'b1;
						MEM_Wr = 1'b0;
						Result_Src = 1'b0;
		end
		default: begin							// I
						PC_Src = 1'b0;
						Reg_Wr = 1'b0;
						IMM_Src = 2'b00;
						ALU_Src = 1'b0;
						MEM_Wr = 1'b0;
						Result_Src = 1'b0;
		end
		endcase
end


wire [16:0] check;
assign check = {{opcode},{funct3},{funct7}};

always @(*) begin
	case(check)
		16'b0000011010xxxxxxx : ALU_Control = 4'b0000; //lw
		16'b0100011010xxxxxxx : ALU_Control = 4'b0000; //sw
		
		16'b01100110000000000 : ALU_Control = 4'b0000; //add
		16'b01100110000100000 : ALU_Control = 4'b0001; //sub
		16'b01100110010000000 : ALU_Control = 4'b0010; //sll
		16'b01100110100000000 : ALU_Control = 4'b0011; //slt
		16'b01100110110000000 : ALU_Control = 4'b0100; //sltu
	   16'b01100111000000000 : ALU_Control = 4'b0101; //xor
	   16'b01100111010000000 : ALU_Control = 4'b0110; //srl\
		16'b01100111010100000 : ALU_Control = 4'b0111; //sra
		16'b01100111100000000 : ALU_Control = 4'b1000; //or
		16'b01100111110000000 : ALU_Control = 4'b1001; //and
		
		16'b0010011000xxxxxxx : ALU_Control = 4'b0000; //addi
		16'b0010011010xxxxxxx : ALU_Control = 4'b0011; //slti
		16'b0010011011xxxxxxx : ALU_Control = 4'b0100; //sltiu
		16'b0010011100xxxxxxx : ALU_Control = 4'b0101; //xori
		16'b0010011110xxxxxxx : ALU_Control = 4'b1000; //ori
		16'b0010011111xxxxxxx : ALU_Control = 4'b1001; //andi
		
		default: ALU_Control = 4'b0000;
		endcase
end

endmodule
