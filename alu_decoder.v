module alu_decoder(
input opb5,funct7b5,
input [2:0]funct3,
input [1:0]alu_op,
output reg  [3:0]alu_control
);
wire rsubtype;
assign rsubtype=funct7b5&opb5&(funct3==3'b000);
always@(*)
begin
case(alu_op)
2'b00:alu_control= 4'b0000;//ADD FOR LOAD/STORE
2'b01:alu_control= 4'b0001;//SUB FOR BRANCH
2'b10:case(funct3)
3'b000:if(rsubtype)
       alu_control=4'b0001;//SUB
else   alu_control=4'b0000;//ADD
3'b001:alu_control=4'b1010;//SLL
3'b010:alu_control=4'b0101;//SLT
3'b011:alu_control=4'b0110;//SLTU
3'b100:alu_control=4'b0100;//XOR
3'b101:
if(funct7b5)
       alu_control=4'b1011;//SRA
else   alu_control=4'b1100;//SRL
3'b110:alu_control=4'b0011;//OR
3'b111:alu_control=4'b0010;//AND
default:alu_control=4'b0000;
endcase
default: alu_control=4'b0000;
endcase
end
endmodule


