module RCA_8bit(a,b,cin,cout,sum);
	input [7:0] a, b;
	input cin;
	output cout;
	output [7:0] sum;
	wire w1,w2,w3,w4,w5,w6,w7;
	
	full_adder f1(a[0], b[0], cin, sum[0], w1);
	full_adder f2(a[1], b[1], w1, sum[1], w2);
	full_adder f3(a[2], b[2], w2, sum[2], w3);
   full_adder f4(a[3], b[3], w3, sum[3], w4);
	full_adder f5(a[4], b[4], w4, sum[4], w5);
	full_adder f6(a[5], b[5], w5, sum[5], w6);
	full_adder f7(a[6], b[6], w6, sum[6], w7);
	full_adder f8(a[7], b[7], w7, sum[7], cout);
	
endmodule
