# Verification Matrix

## Overview

This document tracks verification status, coverage, evidence, and supporting documentation for the RV32I Single-Cycle CPU.

---

## Verification Summary

| Module              | Verification Document                                     | Status | Notes                                     |
| ------------------- | --------------------------------------------------------- | ------ | ----------------------------------------- |
| ALU                 | [ALU Verification](./verification/alu.md)                 | ✅ PASS | Arithmetic, comparison, shifts, flags     |
| Register File       | [Register File Verification](./verification/regfile.md)   | ✅ PASS | Read/write behavior, x0 protection        |
| Data Memory         | [Data Memory Verification](./verification/dmem.md)        | ✅ PASS | Read/write, address translation           |
| Control Unit        | [Control Unit Verification](./verification/cu.md)         | ✅ PASS | Instruction decode and control generation |
| Branch & Jump Logic | [Branch Logic Verification](./verification/branchjump.md) | ✅ PASS | BEQ, BNE, BLT, BGE, JAL                   |
| CPU Integration     | [CPU Verification](./verification/cpu.md)                 | ✅ PASS | End-to-end instruction execution          |

---

## Instruction Coverage

| Instruction | Verification Source            | Status |
| ----------- | ------------------------------ | ------ |
| ADD         | ALU + CPU Integration          | ✅      |
| SUB         | ALU                            | ✅      |
| AND         | ALU                            | ✅      |
| OR          | ALU                            | ✅      |
| XOR         | ALU                            | ✅      |
| SLL         | ALU                            | ✅      |
| SRL         | ALU                            | ✅      |
| SRA         | ALU                            | ✅      |
| SLT         | ALU                            | ✅      |
| SLTU        | ALU                            | ✅      |
| ADDI        | CPU Integration                | ✅      |
| ANDI        | Control Unit + CPU Decode      | ✅      |
| ORI         | Control Unit + CPU Decode      | ✅      |
| XORI        | Control Unit + CPU Decode      | ✅      |
| LW          | CPU Integration                | ✅      |
| SW          | CPU Integration                | ✅      |
| BEQ         | Branch Logic + CPU Integration | ✅      |
| BNE         | Branch Logic + CPU Integration | ✅      |
| BLT         | Branch Logic                   | ✅      |
| BGE         | Branch Logic                   | ✅      |
| JAL         | CPU Integration                | ✅      |

---

## CPU-Level Verification

| Program            | Purpose                                | Status |
| ------------------ | -------------------------------------- | ------ |
| Arithmetic Program | Register operations and ALU datapath   | ✅      |
| Memory Program     | LW / SW functionality                  | ✅      |
| Branch Program     | BEQ / BNE execution                    | ✅      |
| Jump Program       | JAL execution and link register update | ✅      |

See: [CPU Verification](./verification/cpu.md)

---

## Bug History

| Issue                         | Module          | Resolution                  |
| ----------------------------- | --------------- | --------------------------- |
| Shift amount masking          | ALU             | Use b[4:0]                  |
| Signed comparison issue       | ALU             | Use $signed()               |
| x0 write protection           | Register File   | Ignore writes to x0         |
| Address translation confusion | Data Memory     | addr >> 2 indexing          |
| Store-path integration bug    | CPU Integration | DMEM write_data ← rs2       |
| JAL writeback bug             | CPU Integration | Added PC+4 writeback source |

---

## Verification Status

Module Verification:

```text
ALU                 ✓
Register File       ✓
Program Counter     ✓
Instruction Memory  ✓
Decoder             ✓
Immediate Generator ✓
Control Unit        ✓
Data Memory         ✓
Branch Logic        ✓
CPU Integration     ✓
```

Instruction Verification:

```text
R-Type Instructions ✓
I-Type Instructions ✓
S-Type Instructions ✓
B-Type Instructions ✓
J-Type Instructions ✓
```

Overall Status:

```text
Verification Complete ✓
```
