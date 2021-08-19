# BulletProoF-Implementation
## Introduction
This project focus on the implementation of a secure boot method for FPGAs, according to [this paper](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/BulletProoF%20Paper.pdf). On-board encryption key storage is avoided, and a Hardware-Embedded Delay Physical Unclonable Function(HELP) base key generation is used, to generated the encryption key each time when the FPGA board boots. 
## Repo Structure
### MCS Files
This folder containes the generated MCS files that can be directly loaded onto the FPGA board. Detailed explanation for this folder can be found [HERE](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/MCS%20files/README.md).
### Support Files
This folder containes all the files that are used to test function correctness and record testing data. Detailed explanatin for this folder can be found [HERE](https://github.com/xiangyun-wang/BulletProoF-Implementation/blob/main/Support%20Files/README.md).
## Usage
## Calibration
## Phase 1 Integration (Delay Data Generation)
