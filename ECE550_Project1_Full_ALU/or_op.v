module or_op(a,b,result);
   input [31:0] a, b;
   output [31:0] result;
	
   genvar i;
   generate
      for (i = 0; i < 32; i = i+1)
      begin : or_a_b
         or o1(result[i], a[i], b[i]);
      end
   endgenerate
	
endmodule
