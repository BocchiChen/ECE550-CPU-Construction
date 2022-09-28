module a_isnotequal_b(sub_result,result);
	input [31:0] sub_result;
	output result;
	
	assign result = sub_result? 1'b1:1'b0;
	
endmodule
