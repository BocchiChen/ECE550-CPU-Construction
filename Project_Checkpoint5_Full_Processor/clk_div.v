module clk_div ( clk ,rst,out_clk );
	output reg out_clk;
	input clk ;
	input rst;
	always @(clk)
	begin
	if (rst)
		  out_clk <= 1'b0;
	else
		  out_clk <= clk;	
	end
endmodule