# BulletProoF-Implementation
## Introduction
This project focus on the implementation of a secure boot method for FPGAs, according to [this paper](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/BulletProoF%20Paper.pdf). On-board encryption key storage is avoided, and a Hardware-Embedded Delay Physical Unclonable Function(HELP) base key generation is used, to generated the encryption key each time when the FPGA board boots. 
## Repo Structure
### MCS Files (Currently Out of Date, will be updated late August)
This folder containes the generated MCS files that can be directly loaded onto the FPGA board. Detailed explanation for this folder can be below in the Usage section.
### Support Files
This folder containes all the files that are used to test function correctness and record testing data. Detailed explanatin for this folder can be found [HERE](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/Support%20Files/README.md).
### Phase 1 Integration Folder
Delay data can be extracted from the customized SHA3 combo logic. All the VHDL files, constraint file and customized SHA3 IP are included. To reimplement phase 1, create a new project in Vivado and import all source files provided in this folder. Currently, ICAP is still not working. 
### Helper Data Generation Beta Folder
This is an extension to Phase 1 Integration. Delay data can be stored in on-board BRAM, and stability of each delay data can be extracted and stored on-board as well. (Still under testing...)
### Helper Data Generation Beta Folder
This is an extension to Phase 1 Integration and Helper Data Generation. With the delay data and stabilities, key can be generated (hopefully). Customized SHA3 is reused for key generation. (Not tested, will be tested soon...)
## Usage (Out of date, will be updated late August)
### MCS Files (currently out of date, will be updated late August)
MCS files can be directly loaded onto the Arty A7 board for testing. [Calibration.mcs](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/MCS%20files/Calibration.mcs) is used for MPS calibration, and the port mapping can be found in the constraint file (.xdc) provided in the Vivado Project Folder([HERE](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/Vivado%20Project/Calibration/Arty-A7-100-Master.xdc)). (If you are interested in this, [E300ArtyDevKitFPGAChip.mcs](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/MCS%20files/E300ArtyDevKitFPGAChip.mcs) is a SiFive soft-core RISC-V processor).  
## Detailed Documentation For Timing Data Generation Integration (currently out of date, will be updated late August)
A detailed report and documentation is provided [HERE](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/ECSE%20013%20SURE%20Documentation.pdf). It containes explanations for the implementation of the timing data generation, and file explanation for each of the HDL file used.
