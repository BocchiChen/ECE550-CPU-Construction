# ECE550 - Project Checkpoint 1
**Name: Xiuyuan Chen**  
**NetID: xc202**   
Date: 09/18/2022    
## Design Description
The requirement of the project is to build a simple ALU with verliog. My designed ALU can perform 32-bits addition and subtraction based on the LSB (Least Significant Bit) of a control input called ctrl_ALUopcode. If the LSB of ctrl_ALUopcode is 0, then the ALU will perform addition operation. If the LSB of ctrl_ALUopcode is 0, then the ALU will perform addition operation. Two 32-bits inputted operands are treated as signed binary numbers. Overflow can happen whenever unexpected results occur. 
## Design Implementation
I used three 8-bits carry-select adders to build the ALU. Each 8-bits carry-select adder contains three 8-bits ripple carry adders and one  


My hierarchical decoder tree was
alu.v is the top-level entity

the MSB (Most Significant Bit) of  two's complement formats of
