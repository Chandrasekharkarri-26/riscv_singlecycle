module main_decoder(
input  [6:0] op,
input [2:0]funct3,
output [1:0] resultsrc,
output [2:0] immsrc,
output [1:0] alu_op,
output memwrite, alusrc, regwrite, jump, branch
);
reg [11:0] control_signals; 
always @(*) begin
  control_signals = 12'b000000000000;        
  case (op)
    7'b0000011: control_signals = 12'b100010010000; // LW
    7'b0100011: control_signals = 12'b000111000000; // SW
    7'b0110011: control_signals = 12'b100000000100; // R-type
    7'b0010011: begin
      case (funct3)
        3'b000: control_signals = 12'b100010000000; // ADDI
        3'b010: control_signals = 12'b100010000100; // SLTI
        3'b011: control_signals = 12'b100010000100; // SLTIU
        3'b100: control_signals = 12'b100010000100; // XORI
        3'b110: control_signals = 12'b100010000100; // ORI
        3'b111: control_signals = 12'b100010000100; // ANDI
        3'b001: control_signals = 12'b100010000100; // SLLI
        3'b101: control_signals = 12'b100010000100; // SRLI / SRAI 
        default:control_signals = 12'b000000000000; // illegal
      endcase
    end

    7'b1100011: control_signals = 12'b001000001010; // branch
    7'b1101111: control_signals = 12'b101100100001; // JAL
    7'b1100111: control_signals = 12'b100010100001; // JALR
    7'b0110111,
    7'b0010111: control_signals = 12'b110010000000; // LUI / AUIPC
    default   : control_signals = 12'b000000000000;
  endcase
end

assign {regwrite, immsrc, alusrc, memwrite, resultsrc, branch, alu_op, jump} = control_signals;

endmodule
