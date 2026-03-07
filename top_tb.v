`timescale 1ns/1ps
module tb_top;
reg clk;
reg reset;
riscv_top DUT (.clk(clk),
        .reset(reset)
         );
initial 
begin
clk = 0;
forever #5 clk = ~clk;   
end

initial 
begin
reset = 1;
#100;
reset = 0;
end

initial 
begin
$dumpfile("top_tb.vcd");
$dumpvars(0, DUT);
        #5000;
        $finish;
end
endmodule

