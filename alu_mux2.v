module alu_mux2 (
    input [31:0] writedata,
    input [31:0] immext,
    input alusrc,
    output [31:0] srcb
);
assign srcb = alusrc ? immext : writedata;
endmodule
