parse_input(input) = mapreduce(permutedims, vcat, collect.(input))

UDLR_symbols = Dict(
    CartesianIndex(1, 0) => ['|', 'L', 'J'],
    CartesianIndex(0, 1) => ['-', '7', 'J'],
    CartesianIndex(-1, 0) => ['|', '7', 'F'],
    CartesianIndex(0,-1) => ['-', 'F', 'L']
)

UDLR = [ CartesianIndex(1, 0), CartesianIndex(0, 1), CartesianIndex(-1, 0), CartesianIndex(0,-1) ]

symbol_to_UDLR = Dict(
    'S' => UDLR,
    '|' => [CartesianIndex(1, 0), CartesianIndex(-1, 0)],
    '-' => [CartesianIndex(0, 1), CartesianIndex(0, -1)],
    'F' => [CartesianIndex(1, 0), CartesianIndex(0, 1)],
    '7' => [CartesianIndex(1, 0), CartesianIndex(0, -1)],
    'J' => [CartesianIndex(-1, 0), CartesianIndex(0, -1)],
    'L' => [CartesianIndex(-1, 0), CartesianIndex(0, 1)],
)

is_valid(M::Matrix, i::CartesianIndex) = (i[1] >= 1) & (i[2] >= 1) & (i[1] <= size(M)[1]) & (i[2] <= size(M)[2])
find_paths(M::Matrix{Char}, i::CartesianIndex) = filter(i->M[i[2]] in UDLR_symbols[i[1]], filter(i->is_valid(M,i[2]), map(d->(d, d+i), symbol_to_UDLR[M[i]])))
find_paths(M::Matrix{Char}, i::CartesianIndex, prev::CartesianIndex) = filter(x->x[2] != prev, find_paths(M, i))


function find_furthest(M)
    start_i = findfirst(x -> x == 'S', M)
    path = []

    i = start_i

    paths = map(x->x[2], find_paths(M, i))
    path_a = paths[1]
    path_b = paths[2]
    prev_i = i
    i = path_a
    while (i != start_i)
        println("At $i checking for new paths.  $(prev_i)!")
        push!(path, i)
        paths = map(x->x[2], find_paths(M, i, prev_i))
        println(paths)
        prev_i = i
        i = length(paths) == 0 ? start_i : paths[1]
    end

    loop_length = length(path) + 1
    midpoint = ceil(Int, length(path) / 2)
    println("Loop length: $loop_length ; Midpoint: $midpoint")
    distances = [ x <= midpoint ? x : loop_length - x for x in 1:length(path) ]
    println("Distances: $distances")

    return sort(collect( path .=> distances), by=x->x[2], rev=true)[1][1]
end

input = """.....
.S-7.
.|.|.
.L-J.
.....""" |> x -> string.(split(x, "\n"))
M = parse_input(input)
find_furthest(M)


input = """..F7.
.FJ|.
SJ.L7
|F--J
LJ...""" |> x -> string.(split(x, "\n"))

M = parse_input(input)
find_furthest(M)

input = readlines(open("src/inputs/day10.txt"))
parse_input(input) |> find_furthest
