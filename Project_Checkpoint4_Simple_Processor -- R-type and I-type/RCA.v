module RCA_32bit(a,b,cin,cout,sum);
   input [31:0] a, b;
   input cin;
   output cout;
   output [31:0] sum;
	wire [30:0] w;
	
	full_adder fa1(a[0], b[0], cin, w[0], sum[0]);
	genvar i;
	generate
		for(i = 1; i < 31; i = i + 1)
			begin: start
				full_adder fa(a[i], b[i], w[i-1], w[i], sum[i]);
			end
	endgenerate
	full_adder fa2(a[31], b[31], w[30], cout, sum[31]);
	
	
endmodule
