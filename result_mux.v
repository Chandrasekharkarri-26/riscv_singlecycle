module result_mux2(
input [31:0]alu_result,readdata,pc_plus_4,
output [31:0] result,
input [1:0] resultsrc
);
reg [31:0]result1;
always@(*)
begin
 case(resultsrc)
2'b00:result1=alu_result;
2'b01:result1=readdata;
2'b10:result1=pc_plus_4;
default:result1=32'd0;
endcase
end
assign result=result1;
endmodule
