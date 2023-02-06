module PC(address_out,address_in,clock, en, reset);
   //Inputs
   input [31:0] address_in; 
   input clock, reset, en;
   //Output
   output [31:0] address_out;
	
   genvar i;
   generate
      for(i = 0;i<32;i=i+1)
      begin: create_PC
         dffe_ref df(address_out[i],address_in[i],clock,en,reset);
      end 
   endgenerate

endmodule
