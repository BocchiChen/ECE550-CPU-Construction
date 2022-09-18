# ECE550 - Project Checkpoint 1
**Name: Xiuyuan Chen**  
**NetID: xc202**   
Date: 09/18/2022    
## Design Description
The requirement of the project is to build a simple ALU with verliog. My designed ALU can perform 32-bits addition and subtraction based on the LSB (Least Significant Bit) of a control input called ctrl_ALUopcode. If the LSB of ctrl_ALUopcode is 0, then the ALU will perform addition operation. If the LSB of ctrl_ALUopcode is 1, then the ALU will perform subtraction operation. Two 32-bits inputted operands are treated as signed binary numbers. Overflow can happen whenever unexpected results occur. 
## Design Implementation
I used three 16-bits CSAs (carry-select adders) and two 8-bits multiplexers to build the ALU. Each 16-bits CSA contains three 8-bits RCAs (ripple carry adders) and one 8-bits multiplexer.   
The 8-bits RCA was built using eight serial full adders. Each full adder was implemented by standard AND and Ex-OR gates. The full adder can add two binary digits and a carry-in input, and output the sum of the two digits and a carry-out bit. For the 8-bits multiplexer, it was built by eight one-bit multiplexers. The one-bit multiplexer was implemented by standard NOT, AND and OR gates. The 8-bits multiplexer is able to bitwise select the required output based on a control input. An additional one-bit multiplexer was used to select the carry-out bit.   
In the 16-bits CSA, the 

For the subtraction operation, I transform the second operand into two's complement format
Overflow will be set to 1 whenever the MSB (Most Significant Bit) of  two's complement formats of

For my hierarchical decoder tree, alu.v is the top-level entity
