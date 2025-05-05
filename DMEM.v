module DMEM #(
    parameter d_width = 32,
    parameter a_width = 8
)
(
    input clk, rst_n,
    input cs,
    input load_store,
    input [2:0] funct3,
    input [a_width -1 : 0] addr,
    input [d_width -1 : 0] wdata,
    output reg [d_width -1 : 0] rdata
);

reg [d_width -1 : 0] mem [0 : ((1 << a_width) -1 )];

integer i;

// Ghi dữ liệu tại cạnh lên
always @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        for (i = 0; i < (1 << a_width); i = i + 1) begin
            mem[i] <= 32'd0;
        end
    end
    else if (cs && load_store) begin // STORE
        case (funct3)
            3'b000: begin // sb
                mem[addr] <= {{24{wdata[7]}}, wdata[7:0]};
            end
            3'b001: begin // sh
                mem[addr] <= {{16{wdata[15]}}, wdata[15:0]};
            end
            3'b010: begin // sw
                mem[addr] <= wdata;
            end
        endcase
    end
end

// Đọc dữ liệu tại cạnh xuống
always @(negedge clk or negedge rst_n) begin
    if (~rst_n) begin
        rdata <= 32'd0;
    end
    else if (cs && ~load_store) begin // LOAD
        case (funct3)
            3'b000: begin // lb
                rdata <= {{24{mem[addr][7]}}, mem[addr][7:0]};
            end
            3'b001: begin // lh
                rdata <= {{16{mem[addr][15]}}, mem[addr][15:0]};
            end
            3'b010: begin // lw
                rdata <= mem[addr];
            end
            3'b100: begin // lbu
                rdata <= {{24{1'b0}}, mem[addr][7:0]};
            end
            3'b101: begin // lhu
                rdata <= {{16{1'b0}}, mem[addr][15:0]};
            end
        endcase
    end
end

endmodule
