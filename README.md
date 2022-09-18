# ECE550 - Project Checkpoint 1
**Name: Xiuyuan Chen**  
**NetID: xc202**   
Date: 09/18/2022    
## Design Description
The requirement of the project is to build a simple ALU with verliog. My designed ALU can perform 32-bits addition and subtraction based on the LSB (Least Significant Bit) of a control input called ctrl_ALUopcode. If the LSB of ctrl_ALUopcode is 0, then the ALU will perform addition operation. If the LSB of ctrl_ALUopcode is 1, then the ALU will perform subtraction operation. Two 32-bits inputted operands are treated as signed binary numbers. Overflow can happen whenever unexpected results occur. 
## Design Implementation
I used three 16-bits CSAs (carry-select adders) and two 8-bits multiplexers to build the ALU. Each 16-bits CSA contains three 8-bits RCAs (ripple carry adders) and one 8-bits multiplexer.   
  
The 8-bits RCA was built using eight serial full adders. Each full adder was implemented by standard AND and Ex-OR gates. The full adder can add two binary digits and a carry-in input, and output the sum of the two digits and a carry-out bit. For the 8-bits multiplexer, it was built by eight one-bit multiplexers. The one-bit multiplexer was implemented by standard NOT, AND and OR gates. The 8-bits multiplexer is able to bitwise select the required output based on a control input. An additional one-bit multiplexer was used to select the carry-out bit.  
  
In the first 16-bits CSA, the second and third 8-bits RCAs were used to calculate the sum of corresponding high 8 bits and output a carry-out bit, but with a different carry-in input (0 and 1). The outputted sums and carry-out bits were inputted into a following 8-bit multiplexer. The first 8-bits RCA was used to calculate the sum of corresponding low 8 bits and output a carry-out bit, which was inputted into the same 8-bit multiplexer to select the required sum and carry-out bit. The low 16-bits result can be obtained. Subsequently, the selected carry-out bit was used to act as a control signal to select the outcomes of the second CSA and the third CSA. The architectures of the second and third CSA are the same as the first one. The only difference was that the carry-in inputs were set to a fixed value (0 and 1) in advance in order to allow parallel computing. Finally, I used two 8-bits multiplexers to form as a 16-bits multiplexer to select the correct high 16-bits result and the final carry-out bit based on the carry-out bit of the first CSA. As a result, unlike RCA, CSA does not have to wait for the preceding carry-out bits to calaculate the sums, which is much faster than fully RCA. 

For the subtraction operation, I transformed the second operand into its two's complement format and simply added the two operands together as before. Therefore, I used a for-loop to reverse each bit of the second operand and set the carry-in bit of the first CSA to 1. 

Overflow output will be set to 1 whenever the MSB (Most Significant Bit) of the first operand and the MSB of the two's complement format of the second operand are the same, but the MSB of the outputted result is different with which of two operands. 

For my hierarchical decoder tree, alu.v is the top-level entity. add_op.v and sub_op.v are the second-level entity. csa.v are the third entity. RCA_8bit.v and mux_8bit.v are both the fourth entity. full_adder.v and mux.v are the lowest hierarchical level. alu_tb.v was used to test the alu.v.
