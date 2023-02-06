module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;
	//output [31:0] outputRegister;
   output [31:0] data_readRegA, data_readRegB;

	//write part
	wire [31:0] register [31:0];
	wire [31:0] enable_temp, enable_real;
	
	decoder_5to32 d1(ctrl_writeReg, enable_temp);
	genvar i;
	generate
		for(i = 0; i < 32; i = i + 1)
		begin: start1
			and a1(enable_real[i], enable_temp[i], ctrl_writeEnable);
		end
		//the register 0 should always be 0
		reg32 r1(register[0], data_writeReg, clock, 1'b0, ctrl_reset);
		for(i = 1; i < 32; i = i + 1) 
		begin: start2
			reg32 r2(register[i], data_writeReg, clock, enable_real[i], ctrl_reset);
		end
	endgenerate
	
	//read part
	wire [31:0] read_temp [31:0];
	wire [31:0] registerA, registerB;
	//date from register 0 is 0
	assign read_temp[0] = 32'h00000000;
	generate
		for(i = 1; i < 32; i = i + 1)
		begin: start3
			assign read_temp[i] = register[i];
		end
	endgenerate
			
	decoder_5to32 d2(ctrl_readRegA, registerA);
	decoder_5to32 d3(ctrl_readRegB, registerB);
	
	generate
		for(i = 0; i < 32; i = i + 1)
		begin: start4
			AH_tristate t1(read_temp[i], registerA[i], data_readRegA);
			AH_tristate t2(read_temp[i], registerB[i], data_readRegB);
		end
	endgenerate

endmodule
