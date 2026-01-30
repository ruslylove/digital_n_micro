---
layout: cover
transition: fade
theme: seriph
background: https://cover.sli.dev
title: Review - Digital Fundamentals
routeAlias: summary_lectures_1_5

---

# Review: Digital Fundamentals
## Key Concepts and Building Blocks

---


## Digital vs. Analog Signals

- **Analog Signal:** Continuous, infinite range of values (e.g., sound waves, temperature).
- **Digital Signal:** Discrete, finite set of values (typically 0 and 1).



<img src="/lect_1_analog_vs_digital.svg" class="rounded-lg bg-white p-4 h-80 mx-auto" alt="Analog vs Digital Waveforms">
<p class="text-xs text-center">Binary '1' and '0' represent high and low voltage states.</p>

---


## History & Moore's Law

- **Evolution:** Relays $\rightarrow$ Vacuum Tubes $\rightarrow$ Transistors (1947) $\rightarrow$ Integrated Circuits (1958).
- **Moore's Law:** Transistor density on a chip doubles approximately every 18-24 months.

<img src="/lect_1_Moore_s_Law_Transistor_Count_1970-2020.png" class="h-80 mx-auto" alt="Moore's Law Graph">
<p class="text-xs text-center">Price of a transistor is now less than a grain of rice.</p>

---
layout: two-cols
---

## Boolean Algebra & Logic Gates

- **George Boole:** Formalized logic mathematically.
- **Claude Shannon:** Applied Boolean logic to switching circuits.
- **Gate Fundamentals:**
  - **AND:** $Y = A \cdot B$
  - **OR:** $Y = A + B$
  - **NOT:** $Y = A'$

:: right ::

<div class="grid grid-cols-2 gap-2 text-center text-xs">
  <div>
    <img src="/lect_2_and_symbol.svg" class="bg-white p-2 h-40 mx-auto"/>
    <p>AND Gate</p>
  </div>
  <div>
    <img src="/lect_2_or_symbol.svg" class="bg-white p-2 h-40 mx-auto"/>
    <p>OR Gate</p>
  </div>
  <div>
    <img src="/lect_2_not_symbol.svg" class="bg-white p-2 h-30 mx-auto"/>
    <p>NOT Gate</p>
  </div>
</div>

---

## Logic Optimization: Karnaugh Maps

- **K-Map:** A graphical tool to simplify Boolean expressions.
- **Goal:** Minimize the number of gates (SOP or POS forms).
- **Adjacency:** Uses Gray Code; adjacent squares differ by only one bit.

<div class="grid grid-cols-2 gap-8 mt-4">
  <img src="/lect_3_kmap_3var_structure.svg" class="bg-white p-2 h-60 mx-auto rounded-lg"/>
  <ul class="text-base">
    <li>Groups must be powers of 2 (1, 2, 4, 8...).</li>
    <li>Make groups as large as possible.</li>
    <li>Overlap is allowed to maximize group size.</li>
    <li>Don't-cares (X) can be used as 1 or 0.</li>
  </ul>
</div>

---
layout: two-cols
---

## Universal Gates & Standard Forms

- **Universal Gates:** NAND and NOR can implement any logic function.
- **SOP (Sum of Products):** Grouping 1s (OR of ANDs).
- **POS (Product of Sums):** Grouping 0s (AND of ORs).

:: right ::

<div class="text-sm">
  <img src="/lect_3_two_level_sop_nand.svg" class="bg-white p-2 h-48 mx-auto rounded-lg mb-2"/>
  <p class="text-center font-bold">NAND-NAND Implementation</p>
  <img src="/lect_3_two_level_pos_nor.svg" class="bg-white p-2 h-48 mx-auto rounded-lg"/>
  <p class="text-center font-bold">NOR-NOR Implementation</p>
</div>

---
layout: two-cols
---

## Number Systems

- **Binary:** Base-2 (0, 1).
- **Hexadecimal:** Base-16 (0-9, A-F). 1 Hex digit = 4 bits.
- **Signed Numbers:**
  - **Sign-Magnitude:** MSB is sign.
  - **2's Complement:** Invert and add 1.
    - Used in almost all modern computers.
    - Simplifies addition/subtraction.

:: right ::

<div class="text-[0.9rem]">

$$
\begin{array}{rccc}
\hline \text{Dec} & \text{Bin} & \text{Hex} & \text{2's Comp} \\ \hline
+7 & 0111 & 7 & 0111 \\
+6 & 0110 & 6 & 0110 \\
+5 & 0101 & 5 & 0101 \\
+4 & 0100 & 4 & 0100 \\
+3 & 0011 & 3 & 0011 \\
+2 & 0010 & 2 & 0010 \\
+1 & 0001 & 1 & 0001 \\
0 & 0000 & 0 & 0000 \\ \hline
-1 & - & \text{F} & 1111 \\
-2 & - & \text{E} & 1110 \\
-3 & - & \text{D} & 1101 \\
-4 & - & \text{C} & 1100 \\
-5 & - & \text{B} & 1011 \\
-6 & - & \text{A} & 1010 \\
-7 & - & 9 & 1001 \\
-8 & - & 8 & 1000 \\ \hline
\end{array}
$$

</div>

---

## Arithmetic Circuits

- **Half Adder:** Adds 2 bits. $S = A \oplus B$, $C = A \cdot B$.
- **Full Adder:** Adds 2 bits + Carry-in.
- **Ripple Carry Adder:** Cascaded Full Adders; carry "ripples" through.
- **Adder/Subtractor:** Uses XOR gates as controlled inverters for 2's complement subtraction ($A + B' + 1$).

<img src="/lect_4_circuit_adder_subtractor.svg" class="h-70 mx-auto bg-white rounded-lg p-4 mt-4" />

---
layout: two-cols
---

## Combinational Building Blocks

- **Decoder:** $n$-to-$2^n$ lines. Only one output active.
- **Encoder:** Inverse of decoder. $2^n$-to-$n$ lines.
- **Multiplexer (MUX):** Data selector. Selects 1 of $2^n$ inputs.
- **Demultiplexer:** Decoders with enable act as DEMUX.

:: right ::

<img src="/lect_5_mux_4to1_logic.svg" class="bg-white p-4 h-100 mx-auto rounded-lg" />
<p class="text-xs text-center mt-2">4-to-1 Multiplexer Logic</p>

---
layout: two-cols
---

## BCD Adder & Correction

- **BCD (Binary Coded Decimal):** Represents decimal digits 0-9 using 4 bits.
- **Correction:** If the sum $> 9$, add **6 (0110)** to skip invalid codes (10-15).
- **Detection Logic:** $C = K + Z_3Z_2 + Z_3Z_1$

:: right ::

<img src="/lect_5_bcd_adder.svg" class="bg-white p-4 h-110 mx-auto rounded-lg mt-4" />
