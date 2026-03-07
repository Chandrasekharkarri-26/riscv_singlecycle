module data_memory2(
input clk,we,
input [31:0]a,wd,
output [31:0]rd
);

reg [31:0] data_memory [127:0];
integer i;
initial
 begin
  for (i = 0; i < 128; i = i + 1)
    data_memory[i] = 32'b0;
    end
always @(posedge clk)
begin
if(we)
data_memory[a[8:2]] <= wd;
end

assign rd = data_memory[a[8:2]];

endmodule
