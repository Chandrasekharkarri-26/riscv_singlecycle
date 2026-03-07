 module riscv_top(
    input clk,
    input reset,
    output [15:0] led
);
wire [31:0] reg2_value;
wire [31:0] instr;
wire regwrite, memwrite, alusrc,slt,sltu;
wire [1:0] resultsrc;
wire [2:0] immsrc, branch_type;
wire [3:0] alu_control;
wire zero,pcsrc;

control_path cp(
    .op(instr[6:0]),
    .funct3(instr[14:12]),
    .funct7b5(instr[30]),
    .regwrite(regwrite),
    .memwrite(memwrite),
    .zero(zero),
    .pcsrc(pcsrc),
    .alusrc(alusrc),
        .slt(slt),
    .sltu(sltu),
    .resultsrc(resultsrc),
    .immsrc(immsrc),
    .alu_control(alu_control)
);

data_path dp(
    .clk(clk),                  
    .reset(reset),
    .regwrite(regwrite),
    .memwrite(memwrite),
    .alusrc(alusrc),
    .resultsrc(resultsrc),
    .immsrc(immsrc),
    .pcsrc(pcsrc),
    .alu_control(alu_control),
    .zero(zero),
    .slt(slt),
    .sltu(sltu),
    .instr(instr),
    .reg2(reg2_value)
);
assign led = reg2_value[15:0];
endmodule
