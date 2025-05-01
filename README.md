# MEMORY_MODULE

This module implements a simple instruction memory component for use in a 5-stage pipelined RISC-V CPU, specifically targeting the Instruction Fetch (IF) stage.

## Overview

The `INST_MEM` module is a read-only memory (ROM) that holds 32-bit RISC-V instructions. It takes a 32-bit byte address input and outputs the corresponding instruction aligned on 4-byte boundaries.

This repository includes:
- VHDL implementation of the instruction memory
- A testbench (`tb_INST_MEM.vhd` or `tb_inst_memory.vhd`) for verifying correctness
- Example instruction set encoded in RISC-V hex format
- Waveform and Tcl console output showing pass/fail status

## Project Structure
MEMORY_MODULE/
├── images/
│   ├── tcl_tracktest.png
│   ├── tcl1.png
│   ├── tcl2.png
│   ├── wave1.png
│   ├── wave2.png
├── src/
│   ├── INST_MEM.vhd
├── test_benches/
│   ├── tb_INST_MEM.vhd
│   ├── tb_inst_memory.vhd
├── .gitignore/
├── README.md/

## Features
- Byte-addressable interface
- 4-byte alignment (address bits [9:2] used for indexing)
- Simple architecture suitable for simulation and early-stage CPU development

## Testbench Strategy
- The testbench (`tb_INST_MEM.vhd`) verifies instruction memory by comparing each fetched instruction to an expected list.
- The testbench (`tb_inst_memory.vhd`) keep tracks total pass/fail counts and only prints mismatches with address, expected, and actual values

## Key Learnings
- Realized that VHDL `function` behaves like **pass-by-value** in C  
- Understood that VHDL `procedure` acts like **pass-by-reference**  
- Learned to use **array attributes** to make generic, cleaner logic  
- Continuously improving my testbench design for clearer output and better debugging

## Simulation Results
### Tcl Console Output
![Tcl Output](images/tcl_trackfest.png) 
![Tcl Output](images/tcl1.png) 
![Tcl Output](images/tcl2.png) 

### Waveform Example
![Tcl Output](images/wave1.png) 
![Tcl Output](images/wave2.png) 

## How to Run

1. Launch **Vivado 2024.2**
2. Open the project or create a new one and add the src and a test bench file.
3. Set the any of the test bench of your choice as the top simulation unit
4. Go to **Flow → Run Simulation → Run Behavioral Simulation** or 
    in the **project manager, you can directly click the run simulation -> Run Behavioral Simulation**.
5. Open the **Waveform Viewer** to inspect signal transitions
6. View the test results in the **Tcl Console**

## Author

**Noridel Herron** (@MIZZOU)  
Senior in Computer Engineering  
noridel.herron@gmail.com

## Disclaimer

This project is developed solely for educational and personal learning purposes.  
It may contain unfinished or experimental features and is not intended for commercial or production use.

## MIT License

Copyright (c) 2025 Noridel Herron

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
