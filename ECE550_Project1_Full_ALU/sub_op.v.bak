module sub_op(a,b,cout,result,overflow);
	input [31:0] a, b;
   wire [31:0] b_bar;
	output [31:0] result;
	output cout, overflow;
	
	genvar i;
	generate
		for (i = 0; i < 32; i = i+1)
		begin : not_b
			not n(b_bar[i], b[i]);
		end
	endgenerate
	
	csa c2(a,b_bar,1'b1,cout,result,overflow);
	
endmodule
