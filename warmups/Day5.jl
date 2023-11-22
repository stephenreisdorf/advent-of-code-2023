# Read Input
input_raw = open(io->read(io, String), "warmups/inputs/day5.txt")
input = split(input_raw, "\n\n")
initial_state_raw = input[1]
moves_raw = string.(split(input[2], "\n"))

# Split each row into a separate string
intital_state_rows = split(initial_state_raw, "\n")

# Extract only meaningful characters
extract_row(r) = string.(split(r,"")[2:4:34])
initial_start_stacks = extract_row.(intital_state_rows)

# Convert to a Matrix with each row being a column
initial_state_matrix = reverse(permutedims(mapreduce(permutedims, vcat, initial_start_stacks)), dims=2)

# Parse rows into a vector per column
parse_row(r) = filter(x -> x != " ", r)[2:end]
initial_state = parse_row.(eachrow(initial_state_matrix))

# Write a function to execute a move against any given state
function move_crate(state, move)
    from = move[1]
    to = move[2]
    new_state = deepcopy(state)
    crate = pop!(new_state[from])
    push!(new_state[to], crate)
    return new_state
end

# Write a function to convert raw moves to from -> to vectors
function parse_moves(m)
    tokens = split(m, " ")
    num = parse(Int, tokens[2])
    from = parse(Int, tokens[4])
    to = parse(Int, tokens[6])
    return [ [from, to] for i in 1:num ]
end

# List all moves to execute
moves = reduce(vcat, parse_moves.(moves_raw))

# Execute all moves starting from an initial state
final_state = foldl(move_crate, moves, init=initial_state)

# Return Answer
join([ x[end] for x in final_state ])

# Move Stacks at a Time
function move_stack(state, move)
    num = move[1]
    from = move[2]
    to = move[3]
    new_state = deepcopy(state)
    crates = new_state[from][length(new_state[from])-num+1:end]
    new_state[to] = [ new_state[to] ; crates ]
    new_state[from] = new_state[from][begin:length(new_state[from])-num]
    return new_state
end

# Parse stack grain moves
function parse_moves2(m)
    tokens = split(m, " ")
    num = parse(Int, tokens[2])
    from = parse(Int, tokens[4])
    to = parse(Int, tokens[6])
    return [num, from, to]
end

# List all moves to execute
moves2 = parse_moves2.(moves_raw)

# Execute all moves starting from an initial state
final_state2 = foldl(move_stack, moves2, init=initial_state)

# Return Answer
join([ x[end] for x in final_state2 ])
