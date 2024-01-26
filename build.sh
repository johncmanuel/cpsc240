#!/bin/sh

CURR_FOLDER=$(basename "$PWD")

# Find all .asm files in the project folder
for file in *.asm; do
    # Compile each .asm file using YASM
    yasm -g dwarf2 -f elf64 "${file}" -l "${file%.asm}.lst"
done

# Link all object files into an executable
ld -g -o ${CURR_FOLDER} *.o

# Clean up object files
rm *.o
