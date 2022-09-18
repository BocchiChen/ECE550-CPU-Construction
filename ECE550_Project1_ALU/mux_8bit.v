module mux_8bit(s1,w1,s2,w2,ctrl,cout,r);
	input [7:0] s1, s2;
	input w1, w2, ctrl;
	output cout;
	output [7:0] r;
	
	mux m1(s2[0],s1[0],ctrl,r[0]);
	mux m2(s2[1],s1[1],ctrl,r[1]);
	mux m3(s2[2],s1[2],ctrl,r[2]);
	mux m4(s2[3],s1[3],ctrl,r[3]);
	mux m5(s2[4],s1[4],ctrl,r[4]);
	mux m6(s2[5],s1[5],ctrl,r[5]);
	mux m7(s2[6],s1[6],ctrl,r[6]);
	mux m8(s2[7],s1[7],ctrl,r[7]);
	mux m9(w2,w1,ctrl,cout);
	
endmodule
