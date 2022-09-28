module a_lessthan_b(msb_sub_result,sub_overflow,result);
	input msb_sub_result, sub_overflow;
	output result;
	
	xor x1(result,msb_sub_result,sub_overflow);
	
endmodule
