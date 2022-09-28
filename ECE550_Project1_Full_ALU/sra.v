module sra(a,ctrl_shiftamt,result);
   input [31:0] a;
   input [4:0] ctrl_shiftamt;
   output [31:0] result;
   wire [31:0] r1,r2,r3,r4;
	wire [31:0] z;
	
	assign z[31:0] = a[31]? 32'hFFFFFFFF:32'h00000000;

	assign r1[15:0] = ctrl_shiftamt[4]? a[31:16]:a[15:0];
	assign r1[31:16] = ctrl_shiftamt[4]? z[31:16]:a[31:16];
	
	assign r2[23:0] = ctrl_shiftamt[3]? r1[31:8]:r1[23:0];
	assign r2[31:24] = ctrl_shiftamt[3]? z[31:24]:r1[31:24];
	
	assign r3[27:0] = ctrl_shiftamt[2]? r2[31:4]:r2[27:0];
	assign r3[31:28] = ctrl_shiftamt[2]? z[31:28]:r2[31:28];
	
	assign r4[29:0] = ctrl_shiftamt[1]? r3[31:2]:r3[29:0];
	assign r4[31:30] = ctrl_shiftamt[1]? z[31:30]:r3[31:30];
	
	assign result[30:0] = ctrl_shiftamt[0]? r4[31:1]:r4[30:0];
	assign result[31] = ctrl_shiftamt[0]? z[31]:r4[31];
	
endmodule
