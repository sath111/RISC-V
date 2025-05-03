# **RISC-V RV32I Processor with 5-Stage-Pipeline** 
A 32-bit RISC-V processor implemented in Verilog with a 5-stage pipeline. Designed to execute most base RV32I instructions efficiently, with hazard handling support.  

## **Features**
* **Instruction set:** supports most RV32I base integer instructions.  
* **Pipeline Stages:** 5-stages pipeline - Fetch, Decode, Execute, Memory, Writeback.  
* **Hazard handling:** implements data forwarding, pipeline stalling, and flushing for correct instruction execution.  
* **Modular design:** clean separation of datapath, control unit, and memory.  

## **Simulation Guide**   
1. Install a Verilog simulator  
2. Compile source code with testbench  
   ```
   iverilog -o RV32I_PIPELINE_tb RV32I_PIPELINE_tb.v
   ```
   
3. Run the simulator  
   ```
   vvp RV32I_PIPELINE_tb
   ```
5. View waveform output  
   ```
   gtkwave RV32I_PIPELINE_tb.vcd
   ```
   
## **Project Goals**  
The main goal of this project is to **gain hands-on experience in digital design and computer architecture, especially using Verilog**. As this is my first Verilog-based project, some imperfections are to be expected. However, it serves as a valuable foundation for future improvements and more advanced processor designs.

 






