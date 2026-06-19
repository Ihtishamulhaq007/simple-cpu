# Testbench Overview

This directory contains verification testbenches for all major CPU modules.

Each testbench was written to validate functional correctness before module integration into the top-level CPU.

---

## Verification Flow

```text
RTL
→ Testbench
→ Simulation
→ Waveform Analysis
→ Bug Fixing
```

Tools used:

```text
Icarus Verilog
VaporView VCD viewer
GTKWave
```

---

## Available Testbenches

| Testbench       | Purpose                                        |
| --------------- | ---------------------------------------------- |
| alu_tb.v        | Verify ALU operations and flags                |
| regfile_tb.v    | Verify register reads, writes, and x0 behavior |
| pc_tb.v         | Verify program counter updates and reset       |
| ins_tb.v        | Verify instruction memory fetch behavior       |
| immgen_tb.v     | Verify immediate extraction and sign extension |
| decoder_tb.v    | Verify instruction field extraction            |
| cu_tb.v         | Verify control signal generation               |
| dmem_tb.v       | Verify load/store memory operations            |
| branchjump_tb.v | Verify branch and jump address generation      |
| cpu_tb.v        | Verify complete CPU execution                  |

---

## Verification Goals

### ALU

Verified:

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

Carry
Overflow
Zero
Negative
```

---

### Register File

Verified:

```text
Normal Writes
Dual Reads
Read-after-Write
x0 Protection
Highest Register Access
```

---

### Immediate Generator

Verified:

```text
I-Type
S-Type
B-Type
J-Type
```

including positive and negative immediates.

---

### Control Unit

Verified generation of:

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

for all supported instructions.

---

### Data Memory

Verified:

```text
Reads
Writes
Read-after-Write
Address Translation
```

---

### CPU Integration

Verified execution of:

```text
Arithmetic Programs
Memory Programs
Branch Programs
Jump Programs
```

including:

```text
ADD
SUB
ADDI
LW
SW
BEQ
JAL
```

---

## Running Simulations

Example:

```bash
iverilog -o sim rtl/alu.v tb/alu_tb.v
vvp sim
gtkwave dump.vcd
```

The same workflow applies to all module-level testbenches.

---

## Verification Notes

Waveform analysis and verification observations are documented in:

```text
../Verification/
```

Each module has a corresponding verification page containing:

```text
Test Cases
Expected Results
Waveforms
Observations
Conclusions
```
