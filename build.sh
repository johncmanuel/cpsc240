#!/bin/bash

set -e
rm -f -- *.o

output="$(basename "$PWD").out"
assignments=$(find . -mindepth 1 -maxdepth 1 ! -name ".git" -type d -exec basename {} \;)

echo "Choose an assignment to build:"
select a in $assignments; do
  # Must select the number, not the directory name, of the assignment
  # you wish to build 
  if [ -n "$a" ]; then
    break
  else
    echo "Invalid selection. Try again."
  fi
done

# Build the assignment
for file in "${a}"/*.asm; do
  yasm -g dwarf2 -f elf64 "${file}" -l "${file}.lst"
done

# Link all object files into an executable
echo "${output}"
ld -g -o "${output}" *.o

# Clean up object files
rm -f -- *.o
