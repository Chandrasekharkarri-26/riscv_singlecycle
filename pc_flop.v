module pc2(
input [31:0] pcnext,
input clk,reset,
output reg [31:0]pc
);
always@(posedge clk or posedge reset)
pc<=reset?(32'd0):pcnext;
endmodule
