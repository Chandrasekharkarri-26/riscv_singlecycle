module pc_target2(
input [31:0]pc,immext,
output [31:0]pc_target
);
assign pc_target=pc+immext;
endmodule
