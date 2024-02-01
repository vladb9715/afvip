# APB for Verification IP (AFVIP)
Technical Reference Manual
## 1. Introduction
### 1.1. Intended audience
This document is written for RTL Design engineers, Design Verification engineers, and Programmer
engineers who are designing, verifying, or programming SOC systems that use configurable registers
accessed through APB.
### 1.2. Abbreviations
| **Abbreviation** | **Meaning**                                |
|------------------|--------------------------------------------|
| RTL              | Register transfer level                    |
| DV               | Design Verification                        |
| REG              | Register (Flip-Flop)                       |
| AMBA             | Advanced Microcontroller Bus Architecture  |
| APB              | Advanced Peripheral Bus (part of the AMBA) |
| SOC              | System On Chip                             |
### 1.3. Additional Reading
| **Abbreviation**                        | **Meaning**                                                                                                                |
|-----------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| IHI0024E_amba_apb_architecture_spec.pdf | AMBA APB specifications: https://developer.arm.com/documentation/ihi0024/e                                                 |
| afvip_hw_registers.xlsx                 | Registers details document used by a Python program to generate necessary files for Design, Verification, and programming. |
## 2. Component Overview
This module implements an arithmetic unit configurable and controllable through APB interface. Supports only Addition and Multiplication operations.\
Please see below the block diagram and interfaces:\
![Block diagram](https://lh3.googleusercontent.com/drive-viewer/AEYmBYTH_GwIJfZIent8Y48YU0gapYGq3xsuoMAYffp98KcHljtOmw10AEwaZe_EdoudI0LfkehK8pVPl888K8m-RJsNV1aE=s1600)
### 2.1. Features
1. Single clock domain (1GHz)
2. Support asynchronous reset active low
3. The IP uses APB with addresses on 16 bits and data on 32 bits for configuration and status access.\
Please see the address map for all configuration registers:
