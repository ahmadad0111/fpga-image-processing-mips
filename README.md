# FPGA-Based Image Processing System with Custom MIPS Processor and Hardware Accelerators

## 📌 Overview

This project presents a complete FPGA-based image processing system built around a custom-designed MIPS processor architecture. The system integrates multiple hardware components including a processor core, memory modules, and two specialized accelerators (low-area and high-performance versions). These accelerators are designed to explore the trade-off between hardware resource utilization and computational speed.

The main objective of this work is not only to perform image processing on FPGA but also to evaluate architectural design choices in terms of area efficiency, processing throughput, and overall system performance. Image data is stored in on-chip memory and processed through a programmable instruction set, enabling flexible experimentation with different hardware configurations.

The processed output is displayed in real time using a VGA/DVI interface pipeline, making the system suitable for both functional verification and visual output validation.

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

## 📁 Repository Structure

FYP/
|
|-- README.md
|
|-- docs/
│   ├── architecture.md
│   ├── processor.md
│   ├── accelerators.md
│   └── vga.md
│
│
├── Processor/
│   ├── Assembly/
│   │   ├── program.txt        (Assembly code)
│   │   ├── Assembler.jar      (Assembler tool)
│   │   └── program.bin        (Machine code output)
│   │
│   └── processor+vga/
│       ├── MAIN.v
│       ├── vgamult.v
│       ├── vga_logic.v
│       ├── vga_clk.v
│       ├── RAM_88.v
│       ├── image.txt
│       ├── FIB.bin
│       └── other Verilog modules
│
├── Low_Area_Accelerator/
│
├── High_Performance_Accelerator/
│
└── README.md

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
