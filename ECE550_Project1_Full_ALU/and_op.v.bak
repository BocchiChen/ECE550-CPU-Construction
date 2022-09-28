module and_op(a,b,result);
	input [31:0] a, b;
	output [31:0] result;
	
	genvar i;
	generate
		for (i = 0; i < 32; i = i+1)
		begin : and_a_b
			and a1(result[i], a[i], b[i]);
		end
	endgenerate
	
endmodule
