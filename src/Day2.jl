input = readlines(open("src/inputs/day2.txt"))

sample_input = """Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"""

sample_games = string.(split(sample_input, "\n"))

sample_game = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"

bag_contents = Dict("red" => 12, "green" => 13, "blue" => 14)

function parse_draw(d)
    draw_sets = split.(string.(strip.(split(d, ","))), " ")
    return Dict([ (string(s[2]), parse(Int, s[1])) for s in draw_sets ])
end

d = parse_draw("3 blue, 4 red")

function parse_game(g)
    l = string.(split(g, ":"))
    game_number = parse(Int, split(l[1], " ")[end])
    game_draws = string.(strip.(split(strip(l[end]), ";")))
    return parse_draw.(game_draws)
end

g = parse_game(sample_game)

function is_possible(d::Dict{String, Int})
    return (get(d,"red",0) <= get(bag_contents,"red",0)) & (get(d,"blue",0) <= get(bag_contents,"blue",0)) & (get(d,"green",0) <= get(bag_contents,"green",0))
end

function is_possible(g::Vector{Dict{String, Int}})
    return all(is_possible.(g))
end

is_possible(d)
is_possible(g)

sum(Vector(1:length(sample_games))[ is_possible.(parse_game.(sample_games)) ])

sum(Vector(1:length(input))[ is_possible.(parse_game.(input)) ])

function minimum_cubes(g::Vector{Dict{String, Int}})
    Dict(
        "red" => maximum([ get(d, "red", 0) for d in g ]),
        "green" => maximum([ get(d, "green", 0) for d in g ]),
        "blue" => maximum([ get(d, "blue", 0) for d in g ])
    )
end

mc = minimum_cubes(parse_game("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"))
power(mc) = prod(values(mc))
power(mc)

sum(power.(minimum_cubes.(parse_game.(input))))
