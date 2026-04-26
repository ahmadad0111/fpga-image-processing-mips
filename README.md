# FPGA-Based Image Processing System with Custom MIPS Processor and Hardware Accelerators

## Overview

This project implements a complete FPGA-based image processing system built around a custom-designed 32-bit pipelined MIPS processor. The system integrates instruction/data memory, image storage, VGA/DVI display pipeline, and two hardware accelerators (low-area and high-performance designs) to execute image processing directly on FPGA hardware.

The system was initially developed and tested on the **Spartan 3E FPGA Kit**, which provided a basic platform for understanding FPGA design, processor execution, and VGA interfacing. The early experiments focused on simple output verification and VGA signal generation.

![Spartan 3E FPGA Kit](docs/images/spartan3e.png)

Due to limitations in RGB depth and processing capability, the design was migrated to the **Virtex-5 FPGA Video Starter Kit**, which supports 8-bit RGB channels and provides significantly higher resources for image processing and accelerator implementation.

![Virtex 5 FPGA Kit](docs/images/virtex5.png)

The main objective of this project is to evaluate FPGA-based image processing in terms of hardware utilization, execution speed, and architectural trade-offs between a general-purpose processor and specialized accelerators.

---


## 📚 Documentation

Detailed design, architecture explanations, and implementation notes are available in the documentation section:

- [System Architecture](./docs/architecture.md)
- [MIPS Processor Design](./docs/processor.md)
- [Low & High Performance Accelerators](./docs/accelerators.md)
- [VGA / DVI Pipeline Details](./docs/display_pipeline.md)

For full documentation index:  
👉 [Go to Docs](./docs/)

## 🔗 More Details

For extended documentation, architecture diagrams, and implementation notes, visit:  
https://github.com/your-username/fpga-image-processing-fyp


## 🧠 System Flow

Assembly → Assembler → Machine Code (.bin)  
↓  
Instruction Memory → MIPS Processor → Data Memory  
↓  
Image Processing  
↓  
VGA / DVI Output  

---


## ⚙️ Build Flow

### 1. Assemble Code
Run the assembler:

java -jar Assembler.jar program.bin

Output:
factorial.bin

---

### 2. Load Instructions
Instruction memory loads binary:

$readmemb("factorial.bin", IMEM);

---

### 3. Image Memory
Image stored in hex format inside image.txt:

80  
7E  
7D  
7F  
81  

Loaded into RAM using:

initial $readmemh("image.txt", ram);

---

## 🧠 Processing Pipeline

- MIPS processor executes instructions
- Data memory stores intermediate results
- Image is processed pixel-by-pixel

Two accelerators:
- Low Area Accelerator → minimal FPGA resources
- High Performance Accelerator → faster execution

---

## 🖥️ VGA / DVI Output

- vgamult.v integrates processor + display system
- Converts processed image into pixel output
- Works with VGA/DVI interface logic

---

## 🚀 Key Modules

- RAM_88.v → image memory module
- MAIN.v → processor integration
- vga_logic.v → sync generation
- vgamult.v → top-level system

---

## ▶️ How to Run

1. Write assembly in program.bin 
2. Run assembler  
3. Generate factorial.bin  
4. Load into instruction memory  
5. Add image.txt  
6. Synthesize in Vivado  
7. Program FPGA  
8. View output on monitor  

---

## 📌 Notes

- Designed for FPGA boards without native VGA
- Uses DVI-to-VGA conversion logic
