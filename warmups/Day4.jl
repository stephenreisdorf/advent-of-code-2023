## Read Inputs
input = open(io->read(io, String), "warmups/inputs/day4.txt")
encoded_assignments = split.(string.(split(input, "\n")), ",")

## Parse Assignment
x = "21-81"
parse_assignment(x) = collect(parse(Int, split(x,"-")[1]):parse(Int, split(x,"-")[2]))
parse_assignment(x)

## Check Assignment
x = ["21-81", "20-96"]
check_contains(x) = issubset(parse_assignment(x[1]), parse_assignment(x[2])) || issubset(parse_assignment(x[2]), parse_assignment(x[1]))
check_contains(x)

## Combine
sum(check_contains.(encoded_assignments))

## Check Overlap
check_overlap(x) = length(intersect(parse_assignment(x[1]), parse_assignment(x[2]))) > 0
sum(check_overlap.(encoded_assignments))
