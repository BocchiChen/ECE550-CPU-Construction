module mux(a,b,s,out);
	input a,b,s;
	output out;
	wire w1,w2,s_bar;
	
	and a1(w1,a,s);
	not n1(s_bar,s);
	and a2(w2,b,s_bar);
	or o1(out,w1,w2);
	
endmodule
