module reg32(out, in, clk, enable, clr);

	input [31:0] in;
	input clk, enable, clr;
	
	output [31:0] out;
	
	genvar i;
	generate
		for(i = 0; i < 32; i = i + 1) 
			begin: start
				dffe_ref dffe1(out[i], in[i], clk, enable, clr);
			end
	endgenerate
	
endmodule