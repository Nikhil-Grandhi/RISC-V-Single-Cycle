# 32-bit Single-Cycle RISC-V Processor

This repository contains the SystemVerilog source code for a 32-bit single-cycle processor that implements a subset of the RISC-V (RV32I) instruction set architecture. The design is intended for educational purposes and is suitable for synthesis and deployment on an FPGA.

---

## Architecture

The processor follows a classic single-cycle datapath architecture, meaning each instruction is executed in a single clock cycle. It uses a Harvard architecture model with separate memories for instructions and data.

### Datapath

The datapath connects the core functional units of the processor. Based on a classic textbook design, it consists of:
* **Program Counter (PC)**: Manages instruction fetching and is updated with the address of the next instruction, which can be `PC + 4` or a branch/jump target.
* **Instruction Memory (`imem.sv`)**: A read-only memory that stores the 32-bit machine code instructions. It is initialized from an external hex file (`imem.mem`).
* **Register File (`reg_file.sv`)**: Contains 32 general-purpose 32-bit registers. It supports two simultaneous reads (for `rs1`, `rs2`) and one write (`rd`) per clock cycle.
* **Immediate Extender (`imm_extend.sv`)**: Generates the sign-extended 32-bit immediate value from the instruction based on the instruction format (I, S, B, J).
* **Arithmetic Logic Unit (ALU)**: Performs arithmetic and logical operations like addition, subtraction, AND, OR, and Set on Less Than.
* **Data Memory (`dmem.sv`)**: A read-write memory used for load and store operations.

### Control Unit

The control unit is responsible for generating all the necessary control signals for the datapath based on the instruction's opcode. It is composed of two main modules:
* **Main Decoder (`main_dec.sv`)**: Takes the 7-bit opcode as input and generates the primary control signals, including `reg_write`, `mem_write`, `alu_src`, `branch`, and `jump`.
* **ALU Decoder (`ALU_dec.sv`)**: Determines the specific operation the ALU should perform. It uses the `ALU_op` signal from the main decoder, as well as `funct3` and `funct7` fields from the instruction.

---

## Supported Instruction Set (RV32I)

The processor implements a core subset of the RV32I ISA, covering essential operations.

| Type | Instruction | Opcode | Description |
| :--- | :--- | :--- | :--- |
| **R-type** | `add`, `sub`, `and`, `or`, `slt` | `0110011` | Register-register arithmetic/logic operations. |
| **I-type** | `addi` | `0010011` | Add immediate value to a register. |
| **I-type** | `lw` | `0000011` | Load word from memory into a register. |
| **S-type** | `sw` | `0100011` | Store word from a register into memory. |
| **B-type** | `beq`, `bne` | `1100011` | Branch if two registers are equal. |
| **J-type** | `jal` | `1101111` | Jump and Link; store `PC+4` and jump to target. |

---

## File Structure

* `datapath.sv`: The top-level module connecting all datapath components.
* `control.sv`: The top-level control unit that instantiates the decoders.
* `main_dec.sv`: The main decoder that generates control signals from the opcode.
* `ALU_dec.sv`: Decodes the specific ALU operation based on instruction fields.
* `ALU.sv`: The Arithmetic Logic Unit module.
* `imm_extend.sv`: Generates sign-extended immediate values.
* `imem.sv`: The instruction memory module.
* `dmem.sv`: The data memory module.

---

## Getting Started

### Prerequisites
* A SystemVerilog simulator (e.g., Vivado, ModelSim, Verilator).
* A RISC-V assembler to convert assembly code into a 32-bit hex machine code file named `imem.mem`. You can change the name in the code and asd the file also.

### Simulation
1.  Write a RISC-V assembly program using the supported instructions.
2.  Assemble the program into a hex file and name it `imem.mem`. Place it in the simulation directory.
3.  The `imem.sv` module will automatically load this file during simulation initialization.
4.  Set up a project in your EDA tool (like Vivado) and add all the `.sv` source files.
5.  Create a top-level testbench to instantiate the `Top module`, connect them, and provide a clock signal.
6.  Run the simulation. The processor will fetch and execute instructions from the `imem.mem` file.

---

## Future Work
* **ISA Expansion**: Add support for more instructions from the RV32I base integer instruction set.
* **Pipelined Architecture**: Re-architect the design into a 5-stage pipeline (IF, ID, EX, MEM, WB) to improve instruction throughput and overall performance.
