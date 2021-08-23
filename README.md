# BulletProoF-Implementation
## Introduction
This project focus on the implementation of a secure boot method for FPGAs, according to [this paper](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/BulletProoF%20Paper.pdf). On-board encryption key storage is avoided, and a Hardware-Embedded Delay Physical Unclonable Function(HELP) base key generation is used, to generated the encryption key each time when the FPGA board boots. 
## Repo Structure
### MCS Files
This folder containes the generated MCS files that can be directly loaded onto the FPGA board. Detailed explanation for this folder can be below in the Usage section.
### Support Files
This folder containes all the files that are used to test function correctness and record testing data. Detailed explanatin for this folder can be found [HERE](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/Support%20Files/README.md).
### VHDL
This folder containes all VHDL files that are written for this project. Files are further sorted in the folder, and a detailed explanation for each sorted subfolder can be found [HERE](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/VHDL/README.md).
### Vivado Project
There are two Vivado project in this folder. [Calibration](https://github.com/xiangyun-wang/BulletProoF-Implementation/tree/main/Vivado%20Project/Calibration) is used for tap point selection of the Major Phase Shift. The calibration data and selected tap points can be found in the [Support Files](https://github.com/xiangyun-wang/BulletProoF-Implementation/tree/main/Support%20Files) folder.  [Phase1_v1.0](https://github.com/xiangyun-wang/BulletProoF-Implementation/tree/main/Vivado%20Project/Phase1_v1.0) is the integration of the entire timing data generation of the project. All the necessary components are connected, but the actual test is NOT DONE due to the time limit. A detailed documentation of the integrated files can be found under the root directory (will be uploaded no later than Aug. 20). 
## Usage
### MCS Files
MCS files can be directly loaded onto the Arty A7 board for testing. [Calibration.mcs](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/MCS%20files/Calibration.mcs) is used for MPS calibration, and the port mapping can be found in the constraint file (.xdc) provided in the Vivado Project Folder([HERE](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/Vivado%20Project/Calibration/Arty-A7-100-Master.xdc)). [E300ArtyDevKitFPGAChip.mcs](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/MCS%20files/E300ArtyDevKitFPGAChip.mcs) is a SiFive soft-core RISC-V processor. 
### Vivado Project
Try to import the downloaded project into Vivado at first, to see if can work. If it cannot work, simply extract all the VHDL files from the project (or you can find all the VHDL files [HERE](https://github.com/xiangyun-wang/BulletProoF-Implementation/tree/main/VHDL)), then create a new Vivado project. 
## Detailed Documentation For Timing Data Generation Integration
A detailed report and documentation is provided [HERE](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/ECSE%20013%20SURE%20Documentation.pdf). It containes explanations for the implementation of the timing data generation, and file explanation for each of the HDL file used.
