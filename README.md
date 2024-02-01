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
* Single clock domain (1GHz)
* Support asynchronous reset active low
* The IP uses APB with addresses on 16 bits and data on 32 bits for configuration and status access.\
Please see the address map for all configuration registers:

| **APB Address** | **Type** | **Name**                  | **APB Access**        | **Internal Access** |
|-----------------|----------|---------------------------|-----------------------|---------------------|
| _0x0000 – 007C_ | RWS      | Working Registers         | Read/Write access     | Read/Write          |
| _0x0080_        | RW       | Configuration instruction | Read/Write access     | Read                |
| _0x0084_        | RO       | Interrupt status          | Read Only             | Read/Write          |
| _0x0088_        | RWA      | Interrupt Clear           | Read/Write Auto reset | Read                |
| _0x008C_        | RWA      | Control Register          | Read/Write Auto reset | Read                |

For more details about registers please see _afvip_hw_registers.xlsx_ file.
* Instruction format:
![Instruction format](https://lh3.googleusercontent.com/drive-viewer/AEYmBYRz85QWBxq4JdUiNmHXwYp6PnxgdRiP3UiObGS1LdFq-QG4rGIjDZVyJ3oOPLNiaY36uyOH7C5_F7iiC64jLH_FtqlZcQ=s1600)
  * Imm – Immediate value
  * DST – Destination register address
  * RS0 – Source register 0
  * RS1 – Source register 1
  * Opcode – Operation code
* The module supports the next operations according to the operation code:
  * Opcode == 3’d0: reg[dst] = reg[rs0] + imm
  * Opcode == 3’d1: reg[dst] = reg[rs0] * imm
  * Opcode == 3’d2: reg[dst] = reg[rs0] + reg[rs1]
  * Opcode == 3’d3: reg[dst] = reg[rs0] * reg[rs1]
  * Opcode == 3’d4: reg[dst] = reg[rs0] * reg[rs1] + imm
* If the arithmetic operation result exceeds 32 bits, the result written in the destination register will be overlapped. For example:
  * 0xFFFFFFFE + 0x2 = 0x1
  * 0xFFFFFFFF * 0x2 = 0xFFFFFFFE
* Include a set of 32 RW registers mapped in next way:

| **APB Address** | **RS0/RS1/DST Address** | **Name** |
|-----------------|-------------------------|----------|
| _0x0000_        | 0x00                    | reg[00]  |
| _0x0004_        | 0x01                    | reg[01]  |
| _0x0008_        | 0x02                    | reg[02]  |
| _0x000C_        | 0x03                    | reg[03]  |
| _0x0010_        | 0x04                    | reg[04]  |
| _0x0014_        | 0x05                    | reg[05]  |
| _0x0018_        | 0x06                    | reg[06]  |
| _0x001C_        | 0x07                    | reg[07]  |
| _0x0020_        | 0x08                    | reg[08]  |
| _0x0024_        | 0x09                    | reg[09]  |
| _0x0028_        | 0x0A                    | reg[10]  |
| _0x002C_        | 0x0B                    | reg[11]  |
| _0x0030_        | 0x0C                    | reg[12]  |
| _0x0034_        | 0x0D                    | reg[13]  |
| _0x0038_        | 0x0E                    | reg[14]  |
| _0x003C_        | 0x0F                    | reg[15]  |
| _0x0040_        | 0x10                    | reg[16]  |
| _0x0044_        | 0x11                    | reg[17]  |
| _0x0048_        | 0x12                    | reg[18]  |
| _0x004C_        | 0x13                    | reg[19]  |
| _0x0050_        | 0x14                    | reg[20]  |
| _0x0054_        | 0x15                    | reg[21]  |
| _0x0058_        | 0x16                    | reg[22]  |
| _0x005C_        | 0x17                    | reg[23]  |
| _0x0060_        | 0x18                    | reg[24]  |
| _0x0064_        | 0x19                    | reg[25]  |
| _0x0068_        | 0x1A                    | reg[26]  |
| _0x006C_        | 0x1B                    | reg[27]  |
| _0x0070_        | 0x1C                    | reg[28]  |
| _0x0074_        | 0x1D                    | reg[29]  |
| _0x0078_        | 0x1E                    | reg[30]  |
| _0x007C_        | 0x1F                    | reg[31]  |

* The HW-SW handshake will be done according to the control and status registers and the interrupt:
  * _afvip_intr_ - It is a level output signal and can be triggered for 2 reasons:
    * The module finished the instruction execution
    * The module is wrong configured (unsupported opcode)
  * _ev_ctrl_start_ - It is an event type register and is controlled through APB. When this register is written through APB with 1, the module will start processing the configured instruction.
  * _sts_intr_error_ - It is a status register that can be read-only through APB. It indicates when the interrupt is raised because of an illegal configuration.
  * _sts_intr_finish_ - It is a status register that can be read-only through APB. It indicates when the interrupt is raised because the instruction execution is finished.
  * _ev_intr_clr_err_ - It is an event type register, and its job is to clear the error interrupt.
  * _ev_intr_clr_finish_ - It is an event type register, and its job is to clear the finish interrupt.
* The HW-SW handshake for 1 instruction execution is done in 5 steps:
  * _Step 1_ - Configure Registers through APB (Instruction, set values)
  * _Step 2_ - Set start register through APB
  * _Step 3_ - Wait for interrupt
  * _Step 4_ - Read interrupt status
  * _Step 5_ - Clear interrupt
* The Interrupt must be raised in maximum 10 cycles from APB transfer completion of _event_control_start_ register write-access with “1” value. (Minimum 1 cycle).

## 2.2. Limitations
* The configuration must be stable during the instruction execution, from start event until to the interrupt indication.
* The APB will return slave error in the next cases:
  * Decoded address is unknown (Out of the address map)
  * A write access was performed to a read-only register address
  * Address is misaligned at 4 bytes boundary

## 2.3. Input parameters

| **Parameter name** | **Description**                 |
|--------------------|---------------------------------|
| _TP_               | Propagation time for simulation |

## 2.4. Ports
* System Interface

| **Name**     | **Direction** | **Size** | **Description**               |
|--------------|---------------|----------|-------------------------------|
| _clk_        | I             | 1        | Clock                         |
| _rst_n_      | I             | 1        | Asynchronous Reset active low |
| _afvip_intr_ | O             | 1        | Interrupt                     |

* APB Interface

| **Name**  | **Direction** | **Size** | **Description** |
|-----------|---------------|----------|-----------------|
| _psel_    | I             | 1        | Select          |
| _penable_ | I             | 1        | Enable          |
| _paddr_   | I             | 16       | Address         |
| _pwrite_  | I             | 1        | Direction       |
| _pwdata_  | I             | 32       | Write data      |
| _pready_  | O             | 1        | Ready           |
| _prdata_  | O             | 32       | Read data       |
| _pslverr_ | O             | 1        | Transfer error  |

  
