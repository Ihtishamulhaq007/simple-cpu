# RTL Overview

This directory contains the RTL implementation of a 32-bit single-cycle RV32I subset CPU.

Each module was designed, verified independently, and later integrated into the complete processor.

---

## Datapath||CPUINT Overview

```text
PC
 ↓
Instruction Memory
 ↓
Instruction
 ↓
Decoder
 ├──► Control Unit
 ├──► Register File
 └──► Immediate Generator

Register File
 ↓
ALU
 ↓
Data Memory
 ↓
Writeback
 ↓
Register File

Branch/Jump Logic
 ↓
Program Counter
```

---

# Module Index

---

## alu.v

Arithmetic Logic Unit.

### Responsibilities

* Arithmetic operations
* Logical operations
* Shift operations
* Comparison operations
* Flag generation

### Supported Operations

```text
ADD
SUB
AND
OR
XOR
SLL
SRL
SRA
SLT
SLTU
```

### Generated Flags

```text
Zero
Negative
Carry
Overflow
```

Verification:

* See [Here](Verification/alu.md)

---

## registerFile.v

32 × 32-bit register file.

### Features

```text
32 Registers
2 Read Ports
1 Write Port
```

### Behavior

```text
Asynchronous Read
Synchronous Write
```

### Architectural Rule

```text
x0 = 0
```

Writes to x0 are ignored.

Verification:

* See [Here](Verification/regfile.md)

---

## pc.v

Program Counter.

### Responsibilities

Stores the current instruction address.

### Behavior

```text
Reset
→ PC = 0

Clock Edge
→ PC = next_pc
```

Verification:

* See [Here](Verification/pc.md)

---

## instructionMemory.v

Instruction memory used during program execution.

### Responsibilities

```text
Store program instructions
Provide instruction fetch
```

### Access Model

```text
PC
↓
Instruction Memory
↓
32-bit Instruction
```

Verification:

* See [Here](Verification/ins.md)

---

## decoder.v

Instruction field extraction.

### Extracted Fields

```text
opcode
rd
rs1
rs2
funct3
funct7
```

Purpose:

Provides instruction information to:

```text
Control Unit
Register File
Immediate Generator
```

Verification:

* See [Here](Verification/dec.md)

---

## immediateGenerator.v

Immediate reconstruction and sign extension.

### Supported Formats

```text
I-Type
S-Type
B-Type
J-Type
```

### Responsibilities

```text
Immediate extraction
Sign extension
Branch offset generation
Jump offset generation
```

Verification:

* See [Here](Verification/ImmGen.md)

---

## controlUnit.v

Instruction decoding and control generation.

### Inputs

```text
opcode
funct3
funct7
```

### Outputs

```text
RegWrite
MemRead
MemWrite
ALUSrc
MemToReg
Branch
Jump
ALUControl
```

Purpose:

```text
Instruction
↓
Control Signals
```

Verification:

* See [Here](Verification/CU.md)

---

## dmem.v

Data memory.

### Responsibilities

```text
LW
SW
```

### Characteristics

```text
256 Words
32-bit Width
```

### Addressing

```text
Memory Index = Address >> 2
```

Verification:

* See [Here](Verification/dmem.md)

---

## branchJumpLogic.v

Program flow control.

### Responsibilities

```text
Sequential Execution
Conditional Branches
Unconditional Jumps
Internally computes:
- pc + 4
- pc + imm
- branch/jump decisions
```

### Outputs

```text
next_pc
```

Verification:

* See [Here](Verification/BJL.md)

---

## cpu.v

Top-level CPU integration module.

### Responsibilities

Connect all datapath and control modules.

### Provides

```text
Instruction Fetch
Instruction Decode
Register Access
Immediate Generation
Execution
Memory Access
Writeback
```

Verification:

* See [Here](Verification/CPU.md)

---

# Verification

Each RTL module has:

```text
RTL
Testbench
Waveform Verification
```

Detailed verification notes are available in:

```text
../waveforms/
```

---

# Design Philosophy

The project emphasizes:

```text
Clarity
Modularity
Verification
Architecture Understanding
```

over optimization, pipelining, or advanced performance features.

The primary goal is to build a fully functioning CPU from fundamental RTL building blocks.
