using Polynomials

parse_input(input) = map(x->parse.(Int, x), split.(input))

function calculate_polynomial(s)
    x = 1:length(s)
    return fit(x,s)
end

function calculate_next(s)
    f = calculate_polynomial(s)
    return f(length(s)+1)
end

function calculate_previous(s)
    f = calculate_polynomial(s)
    return f(0)
end

input = readlines(open("src/samples/day9.txt"))
sequences = parse_input(input)
sum(calculate_next.(sequences))
calculate_previous.(sequences)

input = readlines(open("src/inputs/day9.txt"))
sequences = parse_input(input)
sum(calculate_next.(sequences)) |> x->ceil(Int, x)
sum(calculate_previous.(sequences)) |> x->ceil(Int, x)
