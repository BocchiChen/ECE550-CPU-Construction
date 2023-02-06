module add_op(a,b,cout,result,overflow);
//The module implements the function of addition operation of ALU
   input [31:0] a, b;
   output [31:0] result;
   output cout, overflow;
	
   csa csa1(a,b,1'b0,cout,result,overflow);
	
endmodule
