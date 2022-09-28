module csa(a,b,cin,cout_final,result,overflow);
   input [31:0] a, b;
   input cin;
   output [31:0] result;
   output cout_final, overflow;
   wire c1,c2,c3,w1,w2,w3,w4,w5,w6,cout1,cout2,cout3,temp,d1,d2;
   wire a_s_bar,b_s_bar,result_s_bar;
   wire [7:0] s1, s2, s3, s4, s5, s6;
   wire [7:0] r1, r2, r3, r4;
	
   //The first CSA
   RCA_8bit ra1(a[15:8],b[15:8],1'b0,w1,s1);
   RCA_8bit ra2(a[15:8],b[15:8],1'b1,w2,s2);
   RCA_8bit ra3(a[7:0],b[7:0],cin,c1,result[7:0]);
   mux_8bit m1(s1,w1,s2,w2,c1,cout1,result[15:8]);
	
   //The second CSA
   RCA_8bit ra5(a[31:24],b[31:24],1'b0,w3,s3);
   RCA_8bit ra6(a[31:24],b[31:24],1'b1,w4,s4);
   RCA_8bit ra7(a[23:16],b[23:16],1'b0,c2,r1);
   mux_8bit m2(s3,w3,s4,w4,c2,cout2,r3);
	
   //The third CSA
   RCA_8bit ra9(a[31:24],b[31:24],1'b0,w5,s5);
   RCA_8bit ra10(a[31:24],b[31:24],1'b1,w6,s6);
   RCA_8bit ra11(a[23:16],b[23:16],1'b1,c3,r2);
   mux_8bit m3(s5,w5,s6,w6,c3,cout3,r4);
	
   //The 16-bits MUX
   mux_8bit m4(r1,1'b0,r2,1'b0,cout1,temp,result[23:16]);
   mux_8bit m5(r3,cout2,r4,cout3,cout1,cout_final,result[31:24]);
	
   //Check whether addition or subtraction has overflow
   not n1(a_s_bar,a[31]);
   not n2(b_s_bar,b[31]);                                                                         
   not n3(result_s_bar,result[31]);
   and a1(d1,a_s_bar,b_s_bar,result[31]);
   and a2(d2,a[31],b[31],result_s_bar);
   or o1(overflow,d1,d2);
	
endmodule
