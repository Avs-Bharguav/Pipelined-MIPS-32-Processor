# 🧠 MIPS32 Processor Design using Verilog

A custom implementation of a 32-bit MIPS processor using Verilog, simulating the instruction pipeline, ALU, memory interface, and control logic.

## 🚀 Features

- Supports I-type, R-type, and J-type instructions
- 5-stage pipeline: Fetch, Decode, Execute, Memory, Writeback
- Hazard detection and forwarding
- Branch and jump instructions support
- Testbench with sample programs

## 📦 Tools Used

- **Verilog HDL**
- **Icarus Verilog** (for simulation)
- **GTKWave** (for waveform viewing)
- **VS Code + Verilog extension**

# REFERENCE: COMPUTER ORGANIZATION AND DESIGN: THE HARDWARE/SOFTWARE INTERFACE. BY DAVID A. PATTERSON AND JOHN L. HENNESSY
(A really amazing book to read)

## 📁 Project Structure

Within next to to three weeks we will try to design a MIPS32 processor which will include R,I and J type instructions and hazard detection and forwarding units.
The MIPS unlike x86 has a fixed length of instructions here 32 bits in length because of which there have to be different formats like R,I and J type.

### Following are the set of instructions in MIPS we will not be including all be all the necessary once. Arthimetic and logical we will be implementing all , load, store, branch equal to and not equal to, Jump and set less than.

![IMG_0964](https://github.com/user-attachments/assets/6af2a4d3-fccf-4bc5-8995-d1f2c9c540cd)

### The following image gives the opcode and function place of the instruction set. ex: to get opcode for addi you need to join the x and y axis row and collumn that is here (001000) and the functional code for add is (100000). we will be giving these will designing the contriller.

![IMG_0967](https://github.com/user-attachments/assets/ede61b60-b4aa-425e-bd6e-ba663abe2220) 


![IMG_0968](https://github.com/user-attachments/assets/30585594-d8dc-4ac8-a497-b56e38ee132e)





