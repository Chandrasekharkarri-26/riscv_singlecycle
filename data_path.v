module data_path(
input pcsrc,memwrite,alusrc,regwrite,
input [3:0]alu_control,
input[2:0]immsrc,
input[1:0]resultsrc,
input clk,reset,
output zero,slt,sltu,
output [31:0]instr,reg2
);
wire[31:0]Pcnext,Pc,Pc_target;
wire[31:0] Instr;
wire[31:0]Immext;
wire[31:0]Srcb,Srca;
wire[31:0]Writedata;
wire[31:0]Result,Readdata,Alu_result;
wire[31:0]Pc_plus_4;

assign instr=Instr;

pcmux2 pcmux1(.pc_target(Pc_target),
              .pcnext(Pcnext),
              	.pcsrc(pcsrc),
              	.pc_plus_4(Pc_plus_4)
              	);
              	
              	
pc2 pc1(.clk(clk),
	.pc(Pc),
	.reset(reset),
	.pcnext(Pcnext)
	);
	
	
instruction_memory2 instruction_memory1(.a(Pc),
					.rd(Instr)
					);
					
					
pc_plus_42 pc_plus_41(.pc(Pc),
		      .pc_plus_4(Pc_plus_4)
		      );		      

	     
extend2 extend1(.immext(Immext),
		.instr(Instr),
		.immsrc(immsrc)
		);
		
		
reg_file2 reg_file1(.a1(Instr[19:15]),
		    .a2(Instr[24:20]),
		    .a3(Instr[11:7]),
		    .wd3(Result),
		    .we3(regwrite),
		    .clk(clk),
		    .rd1(Srca),
		    .rd2(Writedata),
		    .reg2(reg2)
		    );

		    
alu_mux2 alu_mux1(.writedata(Writedata),
		  .immext(Immext),
		  .alusrc(alusrc),
		  .srcb(Srcb)
		  );
		  
		  
alu2 alu1(.a(Srca),
	  .b(Srcb),
	  .alu_control(alu_control),
	  .zero(zero),
	  .slt(slt),
	  .sltu(sltu),
	  .alu_result(Alu_result)
	  );
	  
	  
pc_target2 pc_target1(.pc(Pc),
		      .immext(Immext),
		      .pc_target(Pc_target)
		      );
		      	
		
data_memory2 data_memory1(.a(Alu_result),
			  .wd(Writedata),
			  .we(memwrite),
			  .clk(clk),
			  .rd(Readdata)
			  );

		
result_mux2 result_mux1(.readdata(Readdata),
			.alu_result(Alu_result),
			.resultsrc(resultsrc),
			.result(Result),
			.pc_plus_4(Pc_plus_4)
			);
			
			
endmodule
