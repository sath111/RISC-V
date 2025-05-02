module PC #(
    parameter a_width = 8
)
(
    input clk, rst_n,
    input en,
    input branch,
    input [a_width -1 : 0] PC_current, PC_branch,
    output reg [a_width -1 : 0] PC_next
);

always @(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        PC_next <= 0;
    end
    else begin
        if(branch) begin
            PC_next <= PC_branch;
        end
        else begin
            PC_next <= PC_current + 4;
        end
    end
end

endmodule