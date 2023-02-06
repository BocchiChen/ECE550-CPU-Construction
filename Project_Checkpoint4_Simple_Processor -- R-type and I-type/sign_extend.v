module sign_extend(cin, cout);
	input [16:0] cin;
	output [31:0] cout;
	
	genvar i;
	generate
	for(i = 0; i <= 16; i=i+1)
		begin: copy1
			assign cout[i] = cin[i];
		end
		
	for(i = 17; i < 32; i=i+1)
		begin: copy2
			assign cout[i] = cin[16];
		end
	endgenerate
	
endmodule