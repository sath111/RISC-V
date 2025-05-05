module CONTROL(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,
    input zero,

    output reg en_PC,
    output reg branch,
    output reg src_rf,
    output reg wen_rf,
    output reg [1:0] Imm,
    output reg alu_src,
    output reg [3:0] ALU_control,
    output reg en_dmem,
    output reg load_store,
    output reg [2:0] funct3_dmem,
    output reg writeback
);

always @(*) begin
    en_PC = 0;
    branch = 0;
    src_rf = 0;
    wen_rf = 0;
    Imm = 2'd0;
    alu_src = 0;
    ALU_control = 4'd0;
    en_dmem = 0;
    load_store = 0;
    funct3_dmem = 3'd0;
    writeback = 0;

    case(opcode) 
        7'b0110111: begin
            src_rf = 0; // LUI
            en_PC = 1;
        end
        7'b1100011: begin //branch
            Imm = 2'b10;
            case(funct3) 
                3'b000: begin // beq
                    if(zero) begin
                        en_PC = 1;
                        branch = 1;
                    end
                    else begin
                        en_PC = 0;
                        branch = 0;
                    end
                end
                3'b001: begin // bne
                    if(zero) begin
                        en_PC = 1;
                        branch = 0;
                    end
                    else begin
                        en_PC = 1;
                        branch = 1;
                    end
                end
                default: begin
                    en_PC = 0;
                    branch = 0;
                end
            endcase
        end

        7'b0000011: begin //load
            en_PC = 1;
            src_rf = 1;
            wen_rf = 1;
            Imm = 2'b00;
            alu_src = 1;
            ALU_control = 4'b0000;
            en_dmem = 1;
            load_store = 0;
            funct3_dmem = funct3;
            writeback = 1;
        end

        7'b0100011: begin //store
            en_PC = 1;
            src_rf = 1;
            Imm = 2'b01;
            alu_src = 1;
            ALU_control = 4'b0000;
            en_dmem = 1;
            load_store = 1;
            funct3_dmem = funct3;
        end
        
        7'b0010011: begin //I
            en_PC = 1;
            src_rf = 1;
            wen_rf = 1;
            alu_src = 1;
            writeback = 0;
            case(funct3) 
                3'b000: begin
                    ALU_control = 4'b0000; // addi
                    Imm = 2'b00;
                end
                3'b010: begin
                    ALU_control = 4'b0011; // slti
                    Imm = 2'b00;
                end
                3'b011: begin
                    ALU_control = 4'b0100; //sltiu
                    Imm = 2'b00;
                end
                3'b100: begin
                    ALU_control = 4'b0101; //xori
                    Imm = 2'b00;
                end
                3'b110: begin
                    ALU_control = 4'b1000; //ori
                    Imm = 2'b00;
                end
                3'b111: begin
                    ALU_control = 4'b1001; //andi
                    Imm = 2'b00;
                end
                3'b001: begin //slli
                    ALU_control = 4'b0010; //slli
                    Imm = 2'b11;
                end
                3'b101: begin 
                    Imm = 2'b11;
                    if(funct7 == 7'd0) begin // srli
                        ALU_control = 4'b0110;
                    end
                    else begin //srai
                        ALU_control = 4'b0111;
                    end
                end
                default: begin
                    en_PC = 0;
                    src_rf = 0;
                    alu_src = 0;
                    writeback = 0;
                    ALU_control = 4'b0000;
                    Imm = 2'b00;
                end
            endcase
        end
        
        7'b0110011: begin //R
            en_PC = 1;
            src_rf = 1;
            alu_src = 0;
            writeback = 0;
            case(funct3) 
                3'b000: begin 
                    if(funct7 == 7'd0) begin
                        ALU_control = 4'b0000; // add
                    end
                    else begin
                        ALU_control = 4'b0001; //sub
                    end
                end
                3'b001: begin
                    ALU_control = 4'b0010; //sll
                end
                3'b010: begin
                    ALU_control = 4'b0011; //slt
                end
                3'b011: begin
                    ALU_control = 4'b0100; //sltu
                end
                3'b100: begin
                    ALU_control = 4'b0101; //xor
                end
                3'b101: begin
                    if(funct7 == 7'd0) begin
                        ALU_control = 4'b0110; //srl
                    end
                    else begin
                        ALU_control = 4'b0111; //sra
                    end
                end
                3'b110: begin
                    ALU_control = 4'b1000; //or
                end
                3'b111: begin
                    ALU_control = 4'b1001; //and
                end
                default: begin
                    en_PC = 0;
                    src_rf = 0;
                    alu_src = 0;
                    writeback = 0;
                    ALU_control = 0;
                end
            endcase
        end
        default: begin
            en_PC = 0;
            branch = 0;
            src_rf = 0;
            wen_rf = 0;
            Imm = 2'd0;
            alu_src = 0;
            ALU_control = 0;
            en_dmem = 0;
            load_store = 0;
            funct3_dmem = 3'd0;
            writeback = 0;
        end
    endcase
end

endmodule