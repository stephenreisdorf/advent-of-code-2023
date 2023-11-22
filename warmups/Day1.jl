# Read Input File
input = open(io->read(io, String), "warmups/inputs/day1.txt")

# Parse Input into Vector of Vectors
elf_strings = split.(split(input, "\n\n"), "\n")

# Convert Strings to Integers
elves = [ parse.(Int64, s) for s in elf_strings ]

# Find the highest calories
maximum(sum.(elves))

# Find the sum of the highest three calories
sum(partialsort(sum.(elves), 1:3, rev=true))
