module add_op(a,b,cout,result,overflow);
	input [31:0] a, b;
	output [31:0] result;
	output cout, overflow;
	
	csa c1(a,b,1'b0,cout,result,overflow);
	
endmodule
