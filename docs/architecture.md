# Processor Architecture

## 1. Overview
This project implements a custom MIPS-based processor designed for FPGA-based image processing. The architecture explores trade-offs between simplicity, performance, and hardware utilization.

---

## 2. Processor Classification

### 2.1 Instruction Set Architecture (ISA)

Processors are broadly divided into:

| RISC | CISC |
|------|------|
| Fixed instruction size | Variable instruction size |
| Simple operations | Complex operations |
| Pipelined | Less pipelined |

Our processor follows a **RISC-based MIPS architecture**.

---

### 2.2 Instruction Size

- 32-bit instruction format
- Supports R, I, and J formats

---

### 2.3 CPI (Clock Per Instruction)

| Architecture | CPI | Clock Time |
|-------------|-----|-----------|
| Single Cycle | 1 | Long |
| Multi Cycle | Variable | Short |
| Pipelined | ~1 (throughput) | Short |

---

## 3. Single Cycle Architecture

In single-cycle architecture, each instruction completes in one clock cycle.

### Stages:
- IF – Instruction Fetch  
- ID – Instruction Decode  
- EX – Execute  
- MEM – Memory Access  
- WB – Write Back  

### Limitation:
Clock cycle must match the slowest instruction → inefficient.

---

## 4. Pipelined Architecture (Overview)

To improve performance, pipelining is introduced.

- Multiple instructions execute simultaneously
- Improves throughput (NOT latency)

👉 Detailed explanation available in [pipeline.md](pipeline.md)

---

## 5. Datapath Components

- Program Counter (PC)
- Instruction Memory (IM)
- Register File
- ALU
- Data Memory (DM)
- Control Unit
- Multiplexers (MUX)

---

## 6. Supported Instructions

| Type | Example | Operation |
|------|--------|----------|
| R-Type | add | Arithmetic |
| Load | lw | Read memory |
| Store | sw | Write memory |
| Branch | beq | Conditional |
| Jump | j | Control flow |

---

## 7. Design Motivation

This processor is designed to:
- Execute image processing algorithms
- Interface with FPGA memory (RAM)
- Work with custom accelerators
- Compare performance vs area trade-offs
