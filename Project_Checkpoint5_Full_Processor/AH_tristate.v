module AH_tristate(in, en, out);
	input [31:0] in;
	input en;
	
	output [31:0] out;
	
	genvar i;
	generate 
	for(i = 0; i < 32; i = i + 1)
	begin: start
		assign out[i] = en ? in[i] : 1'bz;
	end
	endgenerate
	
endmodule
