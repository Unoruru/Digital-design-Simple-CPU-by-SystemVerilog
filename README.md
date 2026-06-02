# Digital Design: Simple CPU by SystemVerilog

A small educational SystemVerilog CPU project. The repository builds up an 8-bit datapath CPU from individual modules: ALU, register file, instruction memory, program counter, control unit, and a top-level CPU.

The project includes source files, testbenches, generated VCD waveform files, precompiled Icarus Verilog `.vvp` outputs, a sample machine-code program, and a PDF lab report.

## Repository Contents

| File | Description |
| --- | --- |
| `CPU building by SystemVerilog.pdf` | Lab report documenting the CPU construction and test results |
| `alu.sv` / `alu_tb.sv` | 8-bit ALU and testbench |
| `reg_file.sv` / `reg_file_tb.sv` | 16-register, 8-bit register file and testbench |
| `reg_file_alu.sv` / `reg_file_alu_tb.sv` | Combined register-file and ALU datapath |
| `instruction_memory.sv` / `instruction_memory_tb.sv` | ROM-style instruction memory loaded from `program.txt` |
| `pc.sv` / `pc_tb.sv` | Program counter with reset and branch target selection |
| `instruction_memory_pc.sv` / `instruction_memory_pc_tb.sv` | Combined PC and instruction memory |
| `control_unit.sv` / `control_unit_tb.sv` | Opcode decoder and control-signal generator |
| `cpu.sv` / `cpu_tb.sv` | Top-level CPU and testbench |
| `program.txt` | Sample hex machine-code program |
| `*.vcd` | Generated waveform dumps |
| `*.vvp` | Precompiled Icarus Verilog simulation outputs |

## CPU Overview

The top-level CPU has:

- 8-bit ALU datapath
- 16 general-purpose 8-bit registers
- Register `x0` hardwired to zero
- Register `x15` exposed through `cpu_out`
- 24-bit fixed-width instructions
- 8-bit program counter
- 256-entry instruction ROM loaded from `program.txt`
- Basic branch-on-equal control flow

Top-level module:

```systemverilog
module cpu (
    input  logic       CLK,
    input  logic       reset,
    output logic [7:0] ALUResult,
    output logic [7:0] cpu_out
);
```

## Instruction Format

Instructions are 24 bits wide:

```text
[23:20] opcode
[19:16] WA       destination register
[15:12] RA1      source register A
[11:8]  RA2      source register B
[7:0]   immediate / branch target
```

In `cpu.sv`, these fields are decoded as:

```systemverilog
assign immediate = Instr[7:0];
assign RA2       = Instr[11:8];
assign RA1       = Instr[15:12];
assign WA        = Instr[19:16];
assign opcode    = Instr[23:20];
```

## Instruction Set

| Opcode | Mnemonic | Operation | ALU source B | RegWrite | Branch |
| --- | --- | --- | --- | --- | --- |
| `0000` | `and` | `WA = RA1 & RA2` | register | yes | no |
| `0001` | `or` | `WA = RA1 | RA2` | register | yes | no |
| `0010` | `add` | `WA = RA1 + RA2` | register | yes | no |
| `0011` | `sub` | `WA = RA1 - RA2` | register | yes | no |
| `0100` | `andi` | `WA = RA1 & imm` | immediate | yes | no |
| `0101` | `ori` | `WA = RA1 | imm` | immediate | yes | no |
| `0110` | `addi` | `WA = RA1 + imm` | immediate | yes | no |
| `0111` | `beq` | branch to `imm` if `RA1 - RA2 == 0` | register | no | yes |

The ALU supports:

| `ALUControl` | Operation |
| --- | --- |
| `00` | AND |
| `01` | OR |
| `10` | ADD |
| `11` | SUB |

## Sample Program

`program.txt` contains:

```text
610001
620020
6F0000
701207
211100
6FF001
700003
700007
```

Interpreted by the lab report as:

| Address | Machine code | Assembly-style meaning |
| --- | --- | --- |
| `00` | `610001` | `addi x1, x0, 1` |
| `01` | `620020` | `addi x2, x0, 32` |
| `02` | `6F0000` | `addi x15, x0, 0` |
| `03` | `701207` | `beq x1, x2, 7` |
| `04` | `211100` | `add x1, x1, x1` |
| `05` | `6FF001` | `addi x15, x15, 1` |
| `06` | `700003` | `beq x0, x0, 3` |
| `07` | `700007` | `beq x0, x0, 7` |

The program repeatedly doubles `x1` from `1` until it reaches `32`, increments `x15` on each loop, then remains at instruction `7`.

## Running Simulations

The repository appears to use Icarus Verilog and GTKWave.

Compile and run the CPU testbench:

```powershell
iverilog -g2012 -o cpu_tb.vvp cpu_tb.sv
vvp cpu_tb.vvp
gtkwave cpu_tb.vcd
```

Run an individual module testbench:

```powershell
iverilog -g2012 -o alu_tb.vvp alu_tb.sv
vvp alu_tb.vvp
gtkwave alu_tb.vcd
```

You can use the same pattern for:

```text
control_unit_tb.sv
instruction_memory_tb.sv
instruction_memory_pc_tb.sv
pc_tb.sv
reg_file_tb.sv
reg_file_alu_tb.sv
cpu_tb.sv
```

## Notes

- Testbenches write waveform dumps with `$dumpfile` / `$dumpvars`.
- The committed `.vcd` files can be opened directly in GTKWave.
- The committed `.vvp` files are simulator build artifacts and may be regenerated from the `.sv` sources.
- `instruction_memory.sv` declares `logic [24:0] data_ROM [0:255]`, while `Instr` is 24 bits. The sample program uses 24-bit hex words, so this likely works by truncation but can be tightened to `logic [23:0]`.
- The testbenches are monitor/waveform based and do not contain self-checking assertions.

## Verification

I inspected the HDL, testbenches, sample program, and PDF report. Icarus Verilog (`iverilog`/`vvp`) was not installed in this environment, so simulations were not rerun here.

## License

No project license file is included in this repository.
