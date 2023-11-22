# Read Input File
input = open(io->read(io, String), "warmups/inputs/day2.txt")
rounds = split.(split(input, "\n"), " ")

# Points Mappings
first_names = Dict([ ("A", "Rock"), ("B", "Paper"), ("C", "Scissors") ])
second_names = Dict([ ("X", "Rock"), ("Y", "Paper"), ("Z", "Scissors") ])
first_points = Dict([ "A" => 1, "B" => 2, "C" => 3 ])
second_points = Dict([ "X" => 1, "Y" => 2, "Z" => 3 ])

outcomes = Dict([
    ["A", "X"] => 3,
    ["A", "Y"] => 6,
    ["A", "Z"] => 0,
    ["B", "X"] => 0,
    ["B", "Y"] => 3,
    ["B", "Z"] => 6,
    ["C", "X"] => 6,
    ["C", "Y"] => 0,
    ["C", "Z"] => 3,
])

# Score Rounds
score(r) = outcomes[r] + second_points[r[2]]
sum(score.(rounds))

# Points Re Mappings Mappings
first_names = Dict([ ("A", "Rock"), ("B", "Paper"), ("C", "Scissors") ])
second_names = Dict([ ("X", "Lose"), ("Y", "Draw"), ("Z", "Win") ])
first_points = Dict([ "A" => 1, "B" => 2, "C" => 3 ])
second_points = Dict([ "X" => 1, "Y" => 2, "Z" => 3 ])

# Determine Move
strategy_key = Dict([
    ["A", "X"] => "Z",
    ["A", "Y"] => "X",
    ["A", "Z"] => "Y",
    ["B", "X"] => "X",
    ["B", "Y"] => "Y",
    ["B", "Z"] => "Z",
    ["C", "X"] => "Y",
    ["C", "Y"] => "Z",
    ["C", "Z"] => "X",
])

determine_move(s) = strategy_key[s]
determine_move.(rounds)

# Calculate New Rounds
new_rounds = [ [r[1], determine_move(r)] for r in rounds ]
sum(score.(new_rounds))
