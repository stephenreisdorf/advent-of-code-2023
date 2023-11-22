## Read Input File
input = open(io->read(io, String), "warmups/inputs/day3.txt")
rucksacks = string.(split(input, "\n"))

## Define the Alphabet
alphabet = [ collect('a':'z'); collect('A':'Z') ]

## Parse Compartments
get_compartments(r) = [ first(r, trunc(Int, (length(r)+1)/2) ), last(r, trunc(Int, (length(r)+1)/2) )]
parsed_rucksacks = get_compartments.(rucksacks)

# Compare Compartments
compare_compartments(r) = only(intersect(r[1], r[2]))
common_items = compare_compartments.(parsed_rucksacks)

# Value Common Items
value_item(i) = findfirst(==(i), alphabet)
sum(value_item.(common_items))

# Parse Groups
groups = eachrow(permutedims(reshape(rucksacks, (3,:))))

# Identify Badge
identify_badge(g) = intersect(g[1], g[2], g[3])[1]
sum(value_item.(identify_badge.(groups)))
