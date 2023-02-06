module decoder_5to32(in, out);

	input [4:0] in;
	
	output [31:0] out;
	
	wire [31:0] temp1, temp2, temp3, temp4, temp5;
	wire not_in;
	
	genvar i;
	generate
		//0000x
		not n1(not_in, in[0]);
		and a1(temp1[0], 1'b1, not_in);
		and a2(temp1[1], 1'b1, in[0]);
		for(i = 2; i < 32; i = i + 1)
		begin:start1
			assign temp1[i] = 1'b0;
		end
		
		//0001x
		assign temp2[0] = in[1] ? 1'b0 : temp1[0];
		assign temp2[1] = in[1] ? 1'b0 : temp1[1];
		for(i = 0; i < 30; i = i + 1)
		begin: start2
			mux_2to1 m1(temp1[i+2], temp1[i], in[1], temp2[i+2]);
		end
		
		//001xx
		for(i = 0; i < 4; i = i + 1)
		begin: start3
			assign temp3[i] = in[2] ? 1'b0 : temp2[i];
		end
		
		for(i = 0; i < 28; i = i + 1)
		begin: start4
			mux_2to1 m2(temp2[i+4], temp2[i], in[2], temp3[i+4]);
		end
		
		//01xxx
		for(i = 0; i < 8; i = i + 1)
		begin:start5
			assign temp4[i] = in[3] ? 1'b0 : temp3[i];
		end
		
		for(i = 0; i < 24; i = i + 1)
		begin: start6
			mux_2to1 m3(temp3[i+8], temp3[i], in[3], temp4[i+8]);
		end
		
		//1xxxx
		for(i = 0; i < 16; i = i + 1)
		begin: start7
			assign out[i] = in[4] ? 1'b0 : temp4[i];
		end
		
		for(i = 0; i < 16; i = i + 1)
		begin: start8
			mux_2to1 m4(temp4[i+16], temp4[i], in[4], out[i+16]);
		end
	endgenerate

endmodule
		
		

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		