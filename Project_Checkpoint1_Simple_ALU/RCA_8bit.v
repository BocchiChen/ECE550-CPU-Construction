module RCA_8bit(a,b,cin,cout,sum);
//The function implements the function of 8-bits RCA
   input [7:0] a, b;
   input cin;
   output cout;
   output [7:0] sum;
   wire w1,w2,w3,w4,w5,w6,w7;
	
   full_adder fa1(a[0], b[0], cin, sum[0], w1);
   full_adder fa2(a[1], b[1], w1, sum[1], w2);
   full_adder fa3(a[2], b[2], w2, sum[2], w3);
   full_adder fa4(a[3], b[3], w3, sum[3], w4);
   full_adder fa5(a[4], b[4], w4, sum[4], w5);
   full_adder fa6(a[5], b[5], w5, sum[5], w6);
   full_adder fa7(a[6], b[6], w6, sum[6], w7);
   full_adder fa8(a[7], b[7], w7, sum[7], cout);
	
endmodule
