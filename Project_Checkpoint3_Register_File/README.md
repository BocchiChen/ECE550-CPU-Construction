# ECE550 - Project Checkpoint 3

**Name: Xiuyuan Chen**  
**NetID: xc202**  
Date: 10/08/2022

## Design Description

The requirement of the project is to build a register file with verliog that supports two read ports and one write port. The register file should have 32 32-bit wide registers. The read ports take all the data from registers and select the two registers to read based on two control signals called ctrl_readRegA and ctrl_readRegB. The write port initializes all the 32 registers and selects the register to write based on a control signal called ctrl_writeReg. A signal called ctrl_writeEnable is used to decide whether data from data_writeReg will be written to the selected register. The data of register 0 is always zero no matter what is written to it.

## Design Implementation

The 32-bit registers were built by using one-bit DFFE. Each DFFE initialized its value to zero and would set its value whenever the positive edge of the clock or clear was met. I used a two-dimensional array to represent the 32 32-bit registers. An enable signal was used to control the editability of all the 32 DFFEs.

I used the one-hot method to decode the 5-bit wide input into 32-bit wide output. The decoding method acts muck like a Logical Left-Shift operation on 0x00000001, where the 5-bits wide input decides the shift amount. In that case, only one bit of 32 bits was set to 1 after decoding, which was treated as the number of register to be selected.

For the write port, I used the decoder to get the position of register to write based on ctrl_writeReg. The register 0 was set to zero in advance. A for loop was used to iteratively find the selected register. If the ctrl_writeEnable was low, the decoding result was set to all zero for preventing any write operation. The data to write came from an input signal called data_writeReg.

For the two read ports, I used the decoder to get the position of two registers to read based on ctrl_readRegA and ctrl_readRegB. Tristate buffers were used to select the two registers based on the decoding results. The two reading results were saved respectivly in data_readRegA and data_readRegB.
