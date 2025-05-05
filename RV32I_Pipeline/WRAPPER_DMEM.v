module WRAPPER_DMEM #(
    parameter d_width = 32,
    parameter a_width = 8
)
(
    input clk, rst_n,
    input en,
    input load_store,
    input [1:0] byteadd,
    input [2:0] func,
    input [a_width - 1 : 0] addr,
    input [d_width - 1 : 0] wdata,
    output reg [d_width - 1 : 0] rdata
);

reg [d_width -1 : 0] mem [0: ((1 << a_width) -1)];

integer i;
always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        for(i = 0; i < (1 << a_width); i = i + 1) begin
            mem[i] <= 32'd0;
        end
    end
    else begin
        if(en) begin
            if(load_store) begin
                case (func)
                    3'b000: begin //sb
                        case(byteadd) 
                            2'b00: mem[addr][7:0] <=  wdata[7:0];
                            2'b01: mem[addr][15:8] <= wdata[7:0];
                            2'b10: mem[addr][23:16] <= wdata[7:0];
                            2'b11: mem[addr][31:24] <= wdata[7:0];
                        endcase
                    end
                    3'b001: begin //sh
                        case (byteadd)
                            2'b00: mem[addr][15:0] <= wdata[15:0];
                            2'b01: mem[addr][23:8] <= wdata[15:0];
                            2'b10: mem[addr][31:15] <= wdata[15:0];
                        endcase
                    end
                    3'b010: begin //sw
                        mem[addr] <= wdata;
                    end
                endcase
            end
            else begin
                case(func)
                    3'b000: begin //lb
                        case(byteadd)
                            2'b00: rdata <= {{24{mem[addr][7]}}, mem[addr][7:0]};
                            2'b01: rdata <= {{24{mem[addr][15]}}, mem[addr][15:8]};
                            2'b10: rdata <= {{24{mem[addr][23]}}, mem[addr][23:16]};
                            2'b11: rdata <= {{24{mem[addr][31]}}, mem[addr][31:24]};
                        endcase
                    end
                    3'b001: begin //lh
                        case(byteadd)
                            2'b00: rdata <= {{16{mem[addr][15]}}, mem[addr][15:0]};
                            2'b01: rdata <= {{16{mem[addr][15]}}, mem[addr][23:8]};
                            2'b10: rdata <= {{16{mem[addr][15]}}, mem[addr][31:15]};
                        endcase
                    end
                    3'b010: begin //lw
                        rdata <= mem[addr];
                    end
                    3'b100: begin //lbu
                        case(byteadd)
                            2'b00: rdata <= {{24{1'b0}}, mem[addr][7:0]};
                            2'b01: rdata <= {{24{1'b0}}, mem[addr][15:8]};
                            2'b10: rdata <= {{24{1'b0}}, mem[addr][23:16]};
                            2'b11: rdata <= {{24{1'b0}}, mem[addr][31:24]};
                        endcase
                    end
                    3'b101: begin //lhu
                        case(byteadd)
                            2'b00: rdata <= {{16{1'b0}}, mem[addr][15:0]};
                            2'b01: rdata <= {{16{1'b0}}, mem[addr][23:8]};
                            2'b10: rdata <= {{16{1'b0}}, mem[addr][31:15]};
                        endcase
                    end
                endcase
            end
        end
    end
end


endmodule






