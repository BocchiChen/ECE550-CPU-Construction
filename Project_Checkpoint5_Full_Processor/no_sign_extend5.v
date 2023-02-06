module no_sign_extend5(cin, cout);
	input [26:0] cin;
	output [31:0] cout;
	
	genvar i;
	generate
	for(i = 0; i <= 26; i=i+1)
		begin: copy1
			assign cout[i] = cin[i];
		end
		
	for(i = 27; i < 32; i=i+1)
		begin: copy2
			assign cout[i] = 1'b0;
		end
	endgenerate
	
endmodule