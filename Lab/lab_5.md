---
theme: seriph
background: https://source.unsplash.com/collection/94734566/1920x1080
class: text-center
highlighter: shiki
lineNumbers: false
info: |
  ## Lab 5: Latches, Flip-flops, and Registers
  Digital Circuit and Microprocessor Fundamental
drawings:
  persist: false
transition: slide-left
title: Lab 5 - Latches and Flip-flops
---

# Laboratory Exercise 5
## Latches, Flip-flops, and Registers

Digital Circuit and Microprocessor Fundamental
Semester 2/2025

<div class="pt-12">
  <span @click="$slidev.nav.next" class="px-2 py-1 rounded cursor-pointer" hover="bg-white bg-opacity-10">
    Press Space for next page <carbon:arrow-right class="inline"/>
  </span>
</div>

---

# Introduction

The purpose of this exercise is to investigate:
- Latches
- Flip-flops
- Registers

We will start by showing how storage elements can be created in an FPGA without using its dedicated flip-flops.

---
layout: two-cols
---

# Part I: Gated RS Latch

- **Figure 1** depicts a gated RS latch circuit.
- **Figure 2** shows VHDL code using logic expressions.
- **Figure 3a** shows the implementation using one 4-input LUT.

If implemented in an FPGA with 4-input LUTs, only one LUT is needed.

::right::

<figure>
  <img src="/gated_rs_latch.svg" class="h-60 mx-auto" />
  <figcaption class="text-center text-sm">Figure 1: A gated RS latch circuit.</figcaption>
</figure>

---

# Part I: VHDL Specification

<div class="grid grid-cols-2 gap-4">

<div>

```vhdl {all|12-13}
ENTITY part1 IS
    PORT ( Clk, R, S : IN STD_LOGIC;
           Q : OUT STD_LOGIC);
END part1;

ARCHITECTURE Structural OF part1 IS
    SIGNAL R_g, S_g, Qa, Qb : STD_LOGIC ;
    ATTRIBUTE KEEP : BOOLEAN;
    ATTRIBUTE KEEP OF R_g, S_g, Qa, Qb : SIGNAL IS TRUE;
BEGIN
    R_g <= R AND Clk;
    S_g <= S AND Clk;
    Qa <= NOT (R_g OR Qb);
    Qb <= NOT (S_g OR Qa);
    Q <= Qa;
END Structural;
```

</div>

<div>
  The `KEEP` attribute preserves internal signals $R\_g, S\_g, Qa, Qb$, forcing the compiler to use separate logic elements (Figure 3b).
</div>

</div>

---

# Part I: Implementation Analysis

<figure>
  <img src="/rs_latch_luts.svg" class="h-80 mx-auto" />
  <figcaption class="text-center text-sm">Figure 3b: Implementation with KEEP directive (4 LUTs).</figcaption>
</figure>

---

# Part I: Characteristic Table

| Clk | R | S | Q(t+1) | Description |
|:---:|:-:|:-:|:------:|:-----------:|
| 0 | x | x | Q(t) | Hold |
| 1 | 0 | 0 | Q(t) | Hold |
| 1 | 0 | 1 | 1 | Set |
| 1 | 1 | 0 | 0 | Reset |
| 1 | 1 | 1 | x | Indeterminate |

---

# Part I: Instructions

1. Create a Quartus project for your DE-series board.
2. **Schematic Design:** Implement the circuit using the Block Editor. Verify with functional simulation.
3. **Structural VHDL:** Implement using the code provided.
   - Use `KEEP` attribute.
   - Compile and use **RTL Viewer** and **Technology Map Viewer** to verify structure (Figure 3b).
   - Simulate and verify waveforms match Figure 4.

---

# Part I: Expected Waveforms

<figure>
  <img src="/rs_latch_timing.svg" class="w-full mx-auto" />
  <figcaption class="text-center text-sm">Figure 4: Expected waveforms for the RS latch.</figcaption>
</figure>

---

# Part II: Gated D Latch

**Figure 5** shows the circuit for a gated D latch.

<figure>
  <img src="/gated_d_latch.svg" class="h-60 mx-auto" />
  <figcaption class="text-center text-sm">Figure 5: Circuit for a gated D latch.</figcaption>
</figure>

---

# Part II: Characteristic Table

| Clk | D | Q(t+1) | Description |
|:---:|:-:|:------:|:-----------:|
| 0 | x | Q(t) | Hold |
| 1 | 0 | 0 | Reset |
| 1 | 1 | 1 | Set |

---

# Part II: Instructions

1. Create a new Quartus project.
2. **Schematic:** Implement and simulate.
3. **VHDL:**
   - **Modify** the code from Part I to implement the gated D latch.
   - Use the `KEEP` directive.
   - Verify with Technology Map Viewer.
   - Simulate functionality and timing.
4. **Hardware:**
   - Instantiate in a top-level module.
   - **SW0** -> D, **SW1** -> Clk, **LEDR0** -> Q.
   - Download and test on the board.

---

# Part III: Master-Slave D Flip-Flop

**Figure 6** shows a Master-Slave D Flip-Flop (Negative-Edge Triggered).

<figure>
  <img src="/master_slave_flip_flop.svg" class="h-60 mx-auto" />
  <figcaption class="text-center text-sm">Figure 6: Master-Slave D Flip-Flop.</figcaption>
</figure>

---

# Part III: Characteristic Table

| Clk | D | Q(t+1) | Description |
|:---:|:-:|:------:|:-----------:|
| $\downarrow$ | 0 | 0 | Reset |
| $\downarrow$ | 1 | 1 | Set |
| 0 | x | Q(t) | Hold |
| 1 | x | Q(t) | Hold |

---

# Part III: Instructions

1. Create a new Quartus project.
2. **Schematic:**
   - Create a symbol for the **Gated D Latch** from Part II.
   - Use it to build the Master-Slave Flip-Flop.
   - Simulate.
3. **VHDL:**
   - Create a component for the Gated D Latch.
   - Write a top-level file instantiating two copies of it.
   - **SW0** -> D, **SW1** -> Clock, **LEDR0** -> Q.
   - Download and test.

---

# Part IV: Comparison of Storage Elements

**Figure 7** shows three different storage elements connected to the same inputs.

<figure>
  <img src="/three_storage_elements.svg" class="h-60 mx-auto" />
  <figcaption class="text-center text-sm">Figure 7: Circuit with Gated D Latch, Pos-Edge FF, Neg-Edge FF.</figcaption>
</figure>

---

# Part IV: Waveforms

Observe the different behavior of the three elements in **Figure 8**.

<figure>
  <img src="/three_storage_elements_timing.svg" class="w-full mx-auto" />
  <figcaption class="text-center text-sm">Figure 8: Timing Diagram.</figcaption>
</figure>

---

# Part IV: Instructions

1. Create a new Quartus project.
2. **Schematic:** Implement and simulate.
3. **VHDL:**
   - Instantiate the three storage elements.
   - **Do not** use the `KEEP` directive.
   - Verify usage of dedicated FPGA flip-flops in Technology Map Viewer.
   - Simulate using the inputs shown in Figure 8.

---

# Part V: Registers and Adders

Implement a circuit to sum two 8-bit numbers A and B.

**Workflow:**
1. Input A (SW7-0) -> Store in Register.
2. Input B (SW7-0).
3. Sum S = A + B.

**Display:**
- A on HEX3-2.
- B on HEX1-0.
- Sum S on HEX5-4.
- Carry-out on LEDR(0).

**Controls:**
- **KEY0**: Active-low asynchronous reset.
- **KEY1**: Clock input.

---

# Part V: Instructions

1. Create a new Quartus project.
2. **Schematic:** Implement and simulate.
3. **VHDL:**
   - Write a VHDL file for the functionality.
   - Implement the register, adder, and 7-segment display drivers.
   - Assign pins (Keys, Switches, HEX displays).
   - Download and test.
