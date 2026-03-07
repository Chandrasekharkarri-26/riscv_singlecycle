module reg_file2(
input [4:0]a1,a2,a3,
input [31:0]wd3,
input clk,we3,
output [31:0] rd1,rd2,reg2
);
reg [31:0]register_memory[31:0];
integer i;
initial
 begin
for(i=0;i<32;i=i+1)
register_memory[i]=32'd0;
end
always@(negedge clk)
begin
if(we3 && a3!=0)
register_memory[a3]<=wd3;
end
assign reg2=register_memory[2];
assign rd1=(a1!=0)?register_memory[a1]:0;
assign rd2=(a2!=0)?register_memory[a2]:0;
endmodule
