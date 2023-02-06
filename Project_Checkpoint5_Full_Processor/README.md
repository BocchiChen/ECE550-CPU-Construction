# Project Checkpoint 5

## Group members

- netID: zs148

-  Ziyu Shi

  

- netID: wz173

- Wenxi Zhong

  

- netID: xc202
- Xiuyuan Chen 

## Description of my design implimentation: PC part

Based on the Instruction Machine Code Format and the code in project checkpoint 4, we modified our pc and our datapath signlas according to particular instructions. We set the offset for the next pc value based on the result from ALU to complete branch instructions, meaning it could choose to be PC + 1 or PC + 1 + N, or also directly set specific address for next pc based on J type instructions.

We added seven additional signals (is_j, is_jar, is_jr, is_bne, is_blt, is_bex, is_setx) to identify the J-type instructions based on the ALU opcode. Apart from the initial settings, the write-enable signal (Rwe) of the register file was set to true if either is_jar or is_setx is true. JII-type target field (T) was obtained and unsign-extended to a 32-bit wide integer (unsigned_target). Data that was written to the regfile was selected based on two additional signal (is_jar and is_setx). 



For the bex instruction, we respectively read the data in register 31 and the data in register 0 from regfile, sending them to the alu module to see whether they were equal based on the isNotEqual output, and writing T to $r31 if isnotEqual is true. The same methods applied to the bne instruction. For the blt instruction, we set ctrl_readRegA to $rs and ctrl_readRegB to $rd for reading the data from these two registers in the regfile, sending them to the alu module to see whether $rs is less than $rd based on the isNotEqual and isLessThan outputs, and setting PC to PC+1+N if isnotEqual and ~isLessThan are true.
