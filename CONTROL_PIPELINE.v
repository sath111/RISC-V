module CONTROL_PIPELINE(
    input [6:0] opcode,
    input [2:0] funct3,
    input [6:0] funct7,

    output reg jum,
    output reg branch,
    output reg wen_rf,
    output reg [2:0] Imm,
    output reg alu_src,
    output reg [3:0] ALU_control,
    output reg en_dmem,
    output reg load_store,
    output reg [2:0] funct3_dmem,
    output reg [1:0] writeback
);

always @(*) begin
    jum = 0;
    branch = 0;
    Imm = 0;
    wen_rf = 1;
    alu_src = 0;
    ALU_control = 0;
    en_dmem = 0;
    load_store = 0;
    funct3_dmem = 0;
    writeback = 0;
    
    case(opcode) 
        7'b0110111: begin //lui
            jum = 0;
            branch = 0;
            wen_rf = 1;
            Imm = 3'd5;
            alu_src = 0;
            ALU_control = 0;
            en_dmem = 0;
            load_store = 0;
            funct3_dmem = 0;
            writeback = 0;
        end
        7'b1101111: begin //jal
            jum = 1;
            branch = 0;
            wen_rf = 0;
            Imm = 3'd4;
            alu_src = 0;
            ALU_control = 0;
            en_dmem = 0;
            load_store = 0;
            funct3_dmem = 0;
            writeback = 0;
        end
        7'b1100011: begin //branch
            jum = 0;
            branch = 1;
            wen_rf = 0;
            Imm = 3'd2;
            alu_src = 0;
            ALU_control = 4'b0001;
            en_dmem = 0;
            load_store = 0;
            funct3_dmem = 0;
            writeback = 0;
            /*
            case(funct3) 
                3'b000: begin // beq
                    if(zero) begin
                        branch = 1;
                    end
                    else begin
                        branch = 0;
                    end
                end
                3'b001: begin // bne
                    if(zero) begin
                        branch = 0;
                    end
                    else begin
                        branch = 1;
                    end
                end
                default: begin
                    branch = 0;
                end
            endcase
            */
        end

        7'b0000011: begin //load
            jum = 0;
            branch = 0;
            wen_rf = 1;
            Imm = 0;
            alu_src = 1;
            ALU_control = 4'b0000;
            en_dmem = 1;
            load_store = 0;
            funct3_dmem = funct3;
            writeback = 1;
        end

        7'b0100011: begin //store
            jum = 0;
            branch = 0;
            wen_rf = 0;
            Imm = 1;
            alu_src = 1;
            ALU_control = 4'b0000;
            en_dmem = 1;
            load_store = 1;
            funct3_dmem = funct3;
            writeback = 0;
        end
        
        7'b0010011: begin //I
            jum = 0;
            branch = 0;
            wen_rf = 1;
            alu_src = 1;
            en_dmem = 0;
            load_store = 0;
            funct3_dmem = 0;
            writeback = 0;
            case(funct3) 
                3'b000: begin
                    ALU_control = 4'b0000; // addi
                    Imm = 3'b000;
                end
                3'b010: begin
                    ALU_control = 4'b0011; // slti
                    Imm = 3'b000;
                end
                3'b011: begin
                    ALU_control = 4'b0100; //sltiu
                    Imm = 3'b000;
                end
                3'b100: begin
                    ALU_control = 4'b0101; //xori
                    Imm = 3'b000;
                end
                3'b110: begin
                    ALU_control = 4'b1000; //ori
                    Imm = 3'b000;
                end
                3'b111: begin
                    ALU_control = 4'b1001; //andi
                    Imm = 3'b000;
                end
                3'b001: begin //slli
                    ALU_control = 4'b0010; //slli
                    Imm = 3'b011;
                end
                3'b101: begin 
                    Imm = 3'b011;
                    if(funct7 == 7'd0) begin // srli
                        ALU_control = 4'b0110;
                    end
                    else begin //srai
                        ALU_control = 4'b0111;
                    end
                end
                default: begin
                    jum = 0;
                    branch = 0;
                    Imm = 0;
                    wen_rf = 1;
                    alu_src = 0;
                    ALU_control = 0;
                    en_dmem = 0;
                    load_store = 0;
                    funct3_dmem = 0;
                    writeback = 0;
                end
            endcase
        end
        
        7'b0110011: begin //R
            jum = 0;
            branch = 0;
            Imm = 0;
            wen_rf = 1;
            alu_src = 0;
            en_dmem = 0;
            load_store = 0;
            funct3_dmem = 0;
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
                    jum = 0;
                    branch = 0;
                    Imm = 0;
                    wen_rf = 1;
                    alu_src = 0;
                    ALU_control = 0;
                    en_dmem = 0;
                    load_store = 0;
                    funct3_dmem = 0;
                    writeback = 0;
                end
            endcase
        end
        default: begin
            jum = 0;
            branch = 0;
            wen_rf = 0;
            Imm = 3'd0;
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