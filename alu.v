module alu2(
input signed [31:0]a,b,
input [3:0]alu_control,
output reg zero,
output  slt,sltu,
output reg [31:0]alu_result
);
reg [31:0] resultreg;
wire [31:0]temp,sum;
assign temp=alu_control[0]?~b:b;
assign sum=a+temp+alu_control[0];
assign slt=(a[31]==b[31])?(a<b):a[31];
 assign sltu=($unsigned(a)<$unsigned(b));
always@(*)
begin
case(alu_control)
4'b0000:resultreg<=sum;
4'b0001:resultreg<=sum;
4'b0010:resultreg<=a&b;
4'b0011:resultreg<=a|b;
4'b0100:resultreg<=a^b;
4'b0101:resultreg<={31'b0,slt};
4'b0110:resultreg<={31'b0,sltu};
4'b1010:resultreg<=a<<b[4:0];
4'b1011:resultreg<=a>>>b[4:0];
4'b1100:resultreg<=a>>b[4:0];
default:resultreg<=32'b0;
endcase
zero=(resultreg==32'b0);
alu_result=resultreg;
end

endmodule

