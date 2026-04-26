# Pipeline Architecture

## 1. Overview

Pipelining improves throughput by executing multiple instructions in parallel.

---

## 2. Pipeline Stages

1. IF – Instruction Fetch  
2. ID – Instruction Decode  
3. EX – Execute  
4. MEM – Memory Access  
5. WB – Write Back  

---

## 3. Pipeline Registers

- IF/ID
- ID/EX
- EX/MEM
- MEM/WB

These registers store intermediate results between stages.

---

## 4. Hazards

### 4.1 Data Hazard
Occurs due to dependency between instructions.

**Solution:**
- Forwarding unit

---

### 4.2 Structural Hazard
Occurs due to hardware conflicts.

**Solution:**
- Pipeline stalling

---

### 4.3 Control Hazard
Occurs due to branching.

**Solution:**
- Hazard detection unit
- Pipeline flushing

---

## 5. Key Advantage

- Higher throughput
- Efficient hardware utilization
