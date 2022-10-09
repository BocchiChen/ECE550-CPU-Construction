module register(q, d, clk, en, clr);
   
   //Inputs
   input [31:0] d; 
   input clk, en, clr;
   //Output
   output [31:0] q;
	
   genvar i;
   generate
      for(i = 0;i<32;i=i+1)
      begin: create_register
         dffe_ref df(q[i],d[i],clk,en,clr);
      end 
   endgenerate 	

endmodule
