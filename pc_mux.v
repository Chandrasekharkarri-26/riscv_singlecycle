module pcmux2(
input [31:0] pc_plus_4,pc_target,
input pcsrc,
output [31:0]pcnext
);
assign pcnext=pcsrc?(pc_target):(pc_plus_4);
endmodule
