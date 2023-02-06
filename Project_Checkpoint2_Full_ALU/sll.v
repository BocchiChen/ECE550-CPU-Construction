module sll(a,ctrl_shiftamt,result);
   input [31:0] a;
   input [4:0] ctrl_shiftamt;
   output [31:0] result;
   wire [31:0] r1,r2,r3,r4;
   wire [31:0] z;
	
   assign z = 32'h00000000;

   assign r1[31:16] = ctrl_shiftamt[4]? a[15:0]:a[31:16];
   assign r1[15:0] = ctrl_shiftamt[4]? z[15:0]:a[15:0];
	
   assign r2[31:8] = ctrl_shiftamt[3]? r1[23:0]:r1[31:8];
   assign r2[7:0] = ctrl_shiftamt[3]? z[7:0]:r1[7:0];
	
   assign r3[31:4] = ctrl_shiftamt[2]? r2[27:0]:r2[31:4];
   assign r3[3:0] = ctrl_shiftamt[2]? z[3:0]:r2[3:0];
	
   assign r4[31:2] = ctrl_shiftamt[1]? r3[29:0]:r3[31:2];
   assign r4[1:0] = ctrl_shiftamt[1]? z[1:0]:r3[1:0];
	
   assign result[31:1] = ctrl_shiftamt[0]? r4[30:0]:r4[31:1];
   assign result[0] = ctrl_shiftamt[0]? z[0]:r4[0];
	
endmodule
