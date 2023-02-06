# ECE550 - Project Checkpoint 4

## NetIDs and names

### Partner 1

- netID: zs148
- name: Ziyu Shi

### Partner 2

- netID: wz173
- name: Wenxi Zhong

### Partner 3

- netID: xc202

- name: Xiuyuan Chen

  

## Description of design implimentation

#### Overall Structure

Skeleton is the program that wraps up everything(imem regfile processor dmem) and makes our processor run.  The processor module consisted with five main modules, which were PC, imem, regfile, alu and dmem. workflow of our design is that: 



##### 1. Imem 

The imem (instruction memory) was generated to store all the instruction in machine code format. Each time PC register specified the address of the instruction in imem by taking its lower 12 bits. The instructions fetched from imem basically have two types, which were the R type and I type. The R type instructions can be separated into seven parts. We made several wires to store these seven parts. The corresponding operations of R-type instructions include add, sub, and, or, sll and sra.The I type instructions can be separated into four parts. We also made several wires to store these parts and ignore the overlapped parts. The corresponding operations of R-type instructions include addi, sw and lw. The immediate data was sign-extended to a signed 32-bit integer and inputted into the alu module to perform the addition if we were doing the addi, sw and lw instructions.



##### 2. Fetch instructions from imem

​	This is done by a PC module, which fetchs a next instruction stored in imem at each clock edge. The PC (program counter) module was constructed to initialize the PC register based on 32 DEEFs. The initial address of PC register was set to 0. Each time the PC register was added 1 to help fetch the next instruction stored in the instruction memory. The addition operation was performed by a simple 32-bits RCA.



##### 3. Translate to corresponding operation from instruction

Processor decodes the instruction and translate it to a certain operaton (check whether it's R-type or I-Type, get the address of registers involved and performs the correspoding alu operation) , and write the value to dmem(load it to a register) or write back to Regfile. Based on the Instruction Machine Code Format, we decoded the instruction into different types of operations. We generated several variables to represent appropriate signals according to corresponding bits in instructions, such as is_Rtype, is_lw, is_sw, Rwe, ALUinB, DMwe, Rwd, Rdst, etc. In terms of these signals, we were able to update the required output, as a consequence of which, the value stored in corresponding register or main memory could be properly read out or writen into under the control of signals decoded from instructions.



##### 4. Regfile 

The provided regfile (register file) module was replaced by ours. Our regfile was made up of a decoder_5to32, which was responsible for parsing the 5-bit register number into 32-bit one-hot code to choose corresponding register, a reg32, which was responsible for constituting a 32-bit register, and a AH_tristate, which was an active high tri-state buffer and responsible for providing a high impedance "Z" when "enable" was low. The regfile had total 32 registers, among which the zero register ($r0) was always zero, and the thirtieth register ($r30) stored the overflow value based on different types of overflows whenever an overflow was detected. The value was 1 if overflow happened in any add operation, and was 2 if overflow happened in any addi operation. Otherwise, the overflow value was 3. Two control signals ctrl_readRegA and ctrl_readRegB were used to specify the two registers that would be read from the regfile.



##### 5. Alu

The alu module was created to perform six different operations, which includes addition, subtraction, and, or, logical left shift and arithmetic right shift. It took two operands and perform the operation based on a 5-bit control signal called ctrl_ALUopcode. At the alu operation, an overflow detection would be implmented, and turns 1 when there's overflow happening in add, addi, sub operation. In this case, a corresponding value is written to r$30. the result of alu is the stored into dmem or is used in sw/lw.



##### 6. dmem

The dmem (data memory) module was used to implement the sw and lw operations. For the lw operation, we took the lower 12 bits of the alu output to specify the address of the data to read. The fetched data was putted into q_dmem and written into the register file based on $rd, which decided the address of the register to write. For the sw operation, we took the lower 12 bits of the alu output to specify the address of the data in dmem to write. The wren (write enable for dmem) was set to 1. The data to write into the dmem was the data read from the port B of regfile.



##### 7. clocks

Global clock was divided into half and quarter, and was distribute to different modules based on the workflow of different components. In our implementation, we use clock divided by 4 for regfile and processor clock, the others use input clock.
