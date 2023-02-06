/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;   //the address of insn data
    input [31:0] q_imem;          // insn data stored in ins memory

    // Dmem
    output [11:0] address_dmem;   // 
    output [31:0] data;           // data = data_readRegB
    output wren;                  // writeEnable for Dmem
    input [31:0] q_dmem;          // data fetched from dmem

    // Regfile
    output ctrl_writeEnable;       
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;
	 
    /* YOUR CODE STARTS HERE */
	 wire [31:0] pc_address_out, pc_address_in;
	 wire [4:0] rs, rt, rd;
	 wire [16:0] immed;
	 wire [31:0] signed_immed, data_operandB;
	 wire [31:0] alu_final_output;
	 wire [31:0] BR_result, JP_result;
    wire isNotEqual, isLessThan;
	 wire is_j, is_jal, is_bne, is_blt, is_jr, is_bex, is_setx;
	 wire [31:0] insn;
	 
	 wire add_overflow, addi_overflow, sub_overflow;
	 wire is_add, is_addi;

	 wire [31:0] alu_output; 
	 
	 wire overflow;
	 wire [31:0] data_overflow;
	 wire RCA_cout1, RCA_cout2;
    wire [31:0] pc_plus1, pc_plus_1_N;

	 wire is_Rtype, is_lw, is_sw, Rwe, ALUinB, DMwe, Rwd, Rdst, BR, JP;
	 wire [4:0] ALUop, shamt;
	 wire [4:0] opcode;
	 wire [16:0] N;
	 wire [31:0] signed_N, data_oprandB;
	 wire [26:0] target;
	 wire not_op4, not_op3, not_op2, not_op1, not_op0;
	 wire is_sub;
	 wire I_or_JII;
	 wire [4:0] alu_control;
	 wire temp_overflow;
	 wire [31:0] unsigned_target;


	 //pc
	 //PC pc1(pc_address_out, pc_address_in, clock, 1'b1, reset);
	 //RCA_32bit rca1(pc_address_out, 32'h00000001, 1'b0, RCA_cout, pc_address_in);
	 PC pc1(pc_address_out, pc_address_in, clock, 1'b1, reset);
	 RCA_32bit rca1(pc_address_out, 32'h00000001, 1'b0, RCA_cout1, pc_plus1);
	 RCA_32bit rca2(pc_plus1, signed_immed, 1'b0, RCA_cout1, pc_plus_1_N);
	 assign BR_result = ((is_bne & isNotEqual) | (is_blt & ~isLessThan & isNotEqual)) ? pc_plus_1_N : pc_plus1;
	 assign JP_result = (is_j | is_jal | (is_bex & isNotEqual)) ? unsigned_target : (is_jr ? data_readRegB : BR_result);
	 assign pc_address_in = JP_result;
	 assign address_imem = pc_address_out[11:0];
	 
	 //imem

	 assign insn = q_imem;
	 
	 
	 //regfile
	 
	 // this part is to check whether Rtype or Itype or other operation
	 assign opcode = insn[31:27];
	 
	 not (not_op4, opcode[4]);
	 not (not_op3, opcode[3]);
	 not (not_op2, opcode[2]);
	 not (not_op1, opcode[1]);
	 not (not_op0, opcode[0]);
	 and a1(is_Rtype, not_op4, not_op3, not_op2, not_op1, not_op0);  //= 1 if Rtype,00000
	 and a2(is_addi, not_op4, not_op3, opcode[2], not_op1, opcode[0]);  //= 1 if addi, 00101
	 and a3(is_lw, not_op4, opcode[3], not_op2, not_op1, not_op0);  //=1 if lw ,01000
	 and a4(is_sw, not_op4, not_op3, opcode[2], opcode[1], opcode[0]); //= 1 if sw, 00111
	 and is_add_check(is_add, is_Rtype, ~insn[6],  ~insn[5],  ~insn[4],  ~insn[3],  ~insn[2]); 
	 and is_sub_check(is_sub, is_Rtype, ~insn[6],  ~insn[5],  ~insn[4],  ~insn[3],  insn[2]);
	 and a5(is_j,not_op4, not_op3, not_op2, not_op1, opcode[0]); //00001
	 and a6(is_jal,not_op4, not_op3, not_op2, opcode[1], opcode[0]); //00011
	 and a7(is_jr, not_op4, not_op3, opcode[2], not_op1, not_op0);  //00100
	 and a8(is_bne,not_op4, not_op3, not_op2, opcode[1], not_op0); //00010
	 and a9(is_blt,not_op4, not_op3, opcode[2], opcode[1], not_op0); //00110
	 and a10(is_bex, opcode[4], not_op3, opcode[2], opcode[1], not_op0); //10110
	 and a11(is_setx, opcode[4], not_op3, opcode[2], not_op1, opcode[0]); //10101
	
	 or o1(Rwe, is_Rtype, is_addi, is_lw, is_jal, is_setx);//enable, = 1 when write back to Regfile
	 or o2(ALUinB, is_addi, is_lw, is_sw);//this is mux, =1 when choosing immediate
	 // no need for Rdst
	 assign ctrl_writeEnable = Rwe;
	 assign DMwe = is_sw;      //Enable, only = 1 when sw
	 assign Rwd = is_lw;			//this is mux, only = 1 when lw
	 assign Rdst = is_sw;      //select rt or rd
	 assign BR = 1'b0;         // Branch
	 assign JP = 1'b0;			// Jump
	 // ALUop not needed now
	 
	 assign rs = insn[21:17];  //source register for Rtpye and Itype
	 assign rt = insn[16:12];  // also source register for Rtype
 	 assign rd = insn[26:22];  //destination register for Rtype and Itype
	 assign ctrl_readRegA = is_bex ? 5'b11110 : rs; //data_Operand A always $rs

	 or o3(I_or_JII,is_bne,is_blt,is_jr);
	 assign ctrl_readRegB = is_bex ? 5'b00000 : (I_or_JII? rd:(Rdst ? rd : rt));   //store insn will select $rd as input
	 //assign ctrl_writeReg = rd; // the reg to write back to

	 assign immed = insn[16:0]; 
	 assign target = insn[26:0]; //target
	 sign_extend s1(immed, signed_immed);
	 no_sign_extend5 s2(target,unsigned_target); //target extend
	 assign data_operandB = ALUinB ? signed_immed : data_readRegB;
	 

	 //alu -- all operations for now needs alu 
	
	 assign alu_control = is_Rtype ? insn[6:2] : 5'b0;
	 
	 
	 alu alu_1(data_readRegA, data_operandB, alu_control,
			insn[11:7], alu_output, isNotEqual, isLessThan, temp_overflow);
			
	//assign overflow =  (~is_add && ~is_sub && ~is_addi) ? 0 : temp_overflow;
	 
	 
	 // detect overflow for 3 operations 
	 and a12(add_overflow, is_add, temp_overflow);
	 and a13(sub_overflow, is_sub, temp_overflow);
	 and a14(addi_overflow, is_addi, temp_overflow);
	 or o4(overflow, add_overflow, sub_overflow, addi_overflow);
	 
	 assign ctrl_writeReg = is_jal ? 5'b11111: (is_setx ? 5'b11110 : (~overflow ? rd : 5'b11110));
	 assign data_overflow = add_overflow ? 32'd1 : (addi_overflow ? 32'd2 : (sub_overflow ? 32'd3 : 32'd0));

	 assign alu_final_output = ~overflow ? alu_output : data_overflow;
	 assign data_writeReg = is_jal? pc_plus1 : (is_setx ? unsigned_target : (Rwd ? q_dmem : alu_final_output));
	 //assign data_writeReg = alu_output;
	 
	 //dmem
	 assign wren = DMwe;
	 assign data = data_readRegB;
	 assign address_dmem = alu_final_output[11:0];
	 
endmodule