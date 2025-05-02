module HAZARD_UNIT(
    input [4:0] rs1D, rs2D,
    input [4:0] rs1E, rs2E,
    input [4:0] rdM, rdW, rdE,
    input [1:0] writebackE,
    input wen_rfM, wen_rfW,
    input en_branch,
    input rst_n,


    output reg [1:0] fw_AE, fw_BE,
    output reg STALLPCF, STALLD, FLUSHD, FLUSHE
);

//data_forwarding
always @(*) begin
    if(~rst_n) begin
        fw_AE = 0;
    end
    else begin
        if((rs1E == rdM) & wen_rfM) begin
            fw_AE = 2'b01;
        end
        else if((rs1E == rdW) & wen_rfW) begin
            fw_AE = 2'b10;
        end
        else begin
            fw_AE = 2'b00;
        end
    end
end

always@(*) begin
    if(~rst_n) begin
        fw_BE = 0;
    end
    else begin
        if((rs2E == rdM) & wen_rfM) begin
            fw_BE = 2'b01;
        end
        else if((rs2E == rdW) & wen_rfW) begin
            fw_BE = 2'b10;
        end
        else begin
            fw_BE = 2'b00;
        end
    end 
end


//stall lw
always@(*) begin
    if(~rst_n) begin
        STALLPCF = 1;
        STALLD = 1;
        FLUSHE = 0;
        FLUSHD = 0;
    end
    else begin
        if((writebackE == 2'b01) & ((rs1D == rdE) | (rs2D == rdE))) begin
            STALLPCF = 0;
            STALLD   = 0;
            FLUSHE   = 0;
            FLUSHD = 1;
        end
        else if(en_branch) begin
            FLUSHD = 0;
            STALLPCF = 1;
            STALLD = 1;
            FLUSHE = 0;
        end
        else begin
            STALLPCF = 1;
            STALLD = 1;
            FLUSHE = 1;
            FLUSHD = 1;
        end
    end
    
end


endmodule