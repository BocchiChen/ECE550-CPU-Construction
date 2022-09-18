module full_adder(a,b,cin,sum,cout);
	input a,b,cin;
	wire nab,ab, nabc;
	output sum,cout;
	
	xor x1(nab,a,b);
	xor x2(sum,nab,cin);
	and a1(ab,a,b);
	and a2(nabc,nab,cin);
	or o1(cout,ab,nabc);
	
endmodule
