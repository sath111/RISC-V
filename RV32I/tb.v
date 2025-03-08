`timescale 1ns/1ps

module tb;

reg clk;
reg rst_n;

always #5 clk = ~clk;  // Tạo clock 10ns

initial begin
    clk = 0;
    rst_n = 0;
    #20;
    rst_n = 1;  // Thả reset sau 20ns
end

// Instance top module
top DUT (
    .clk(clk),
    .rst_n(rst_n)
);

// Kết thúc mô phỏng sau 1000ns
initial begin
    #1000;
    $stop;  // Dừng mô phỏng (ModelSim sẽ dừng ở đây để bạn xem waveform)
end

endmodule
