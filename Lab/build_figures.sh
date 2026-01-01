#!/bin/bash

# Ensure public directory exists
mkdir -p public

# Function to compile a tex file to svg
compile_figure() {
    local input_file=$1
    local output_name=$2
    
    echo "Compiling $input_file to public/$output_name.svg..."
    
    # Create a temporary wrapper wrapper.tex
    cat <<EOF > wrapper.tex
\documentclass[12pt, dvisvgm]{standalone}
\usepackage[utf8]{inputenc}
\usepackage{tikz}
\usepackage{circuitikz}
\usetikzlibrary{shapes, arrows, calc, positioning, circuits.logic.US, circuits.logic.IEC}
\begin{document}
\input{$input_file}
\end{document}
EOF

    # Compile to DVI
    latex -output-format=dvi -interaction=nonstopmode wrapper.tex > /dev/null

    # Convert to SVG
    dvisvgm --no-fonts wrapper.dvi -o "public/$output_name.svg"

    # Cleanup
    rm wrapper.tex wrapper.dvi wrapper.log wrapper.aux
}

# Compile all figures
compile_figure "Lab/tex/lab6p1_gated_rs_latch.tex" "gated_rs_latch"
compile_figure "Lab/tex/lab6p1_rs_latch_luts.tex" "rs_latch_luts"
compile_figure "Lab/tex/lab6p1_rs_latch_timing.tex" "rs_latch_timing"
compile_figure "Lab/tex/lab6p2_gated_d_latch.tex" "gated_d_latch"
compile_figure "Lab/tex/lab6p3_master_slave_flip_flop.tex" "master_slave_flip_flop"
compile_figure "Lab/tex/lab6p4_three_storage_elements.tex" "three_storage_elements"
compile_figure "Lab/tex/lab6p4_three_storage_elements_timing.tex" "three_storage_elements_timing"

echo "Done!"
