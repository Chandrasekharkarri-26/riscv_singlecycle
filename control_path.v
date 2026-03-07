module control_path(
input [6:0]op,
input [2:0]funct3,
input funct7b5,zero,slt,sltu,
output [3:0]alu_control,
output [1:0]resultsrc,
output [2:0]immsrc,
output memwrite,alusrc,regwrite,
output pcsrc
);
wire [1:0]Aluop;
wire Jump,Branch;
wire branch_taken;

main_decoder main_decoder1(.op(op),
			   .resultsrc(resultsrc),
			   .immsrc(immsrc),
			   .regwrite(regwrite),
			   .alusrc(alusrc),
			   .alu_op(Aluop),
			   .memwrite(memwrite),
			   .jump(Jump),
			   .funct3(funct3),
			   .branch(Branch)
			   );
			   
			   
alu_decoder alu_decoder1(.opb5(op[5]),
			   .funct7b5(funct7b5),
			 .funct3(funct3),
			 .alu_op(Aluop),
			 .alu_control(alu_control)
			 );
assign branch_taken =
    ((funct3 == 3'b000) && zero) ||     // BEQ
    ((funct3 == 3'b001) && !zero) ||    // BNE
    ((funct3 == 3'b100) && slt) ||      // BLT
    ((funct3 == 3'b101) && !slt) ||     // BGE
    ((funct3 == 3'b110) && sltu) ||     // BLTU
    ((funct3 == 3'b111) && !sltu);      // BGTU
    
assign pcsrc = (Branch & branch_taken) | Jump;

	endmodule
