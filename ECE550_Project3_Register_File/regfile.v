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

   output [31:0] data_readRegA, data_readRegB;

   /* YOUR CODE HERE */
   wire [31:0] reg32[31:0];
   wire [31:0] data_writeDecd, data_writeEnable, data_readDecdA, data_readDecdB;
	
	//write port
   Decd d1(ctrl_writeReg, data_writeDecd);
	register reg0(reg32[0],32'h00000000,clock,1'b0,1'b0);
	assign data_writeEnable = ctrl_writeEnable? data_writeDecd:32'h00000000;
   genvar i;
   generate
      for (i = 1; i < 32; i = i+1)
      begin : write_registers
         register regs(reg32[i], data_writeReg, clock, data_writeEnable[i], ctrl_reset);
      end
   endgenerate
	
   //read port A
   Decd d2(ctrl_readRegA, data_readDecdA);
   generate
      for (i = 0; i < 32; i = i+1)
      begin : read_registerA
         assign data_readRegA = data_readDecdA[i]? reg32[i]:32'bz;
      end
   endgenerate
   
   //read port B
   Decd d3(ctrl_readRegB, data_readDecdB);
   generate
      for (i = 0; i < 32; i = i+1)
      begin : read_registerB
         assign data_readRegB = data_readDecdB[i]? reg32[i]:32'bz;
      end
   endgenerate

endmodule
