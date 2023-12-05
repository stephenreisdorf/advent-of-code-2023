struct Card
    i::Int
    winning_numbers::Vector{String}
    my_numbers::Vector{String}
end

function parse_card(s::String)
    i = parse(Int, split(split(s, ":")[1])[end])
    winning_numbers = string.(split(split(split(s, ":")[2], " | ")[1]))
    my_numbers = string.(split(split(split(s, ":")[2], " | ")[2]))
    return Card(i, winning_numbers, my_numbers)
end

function determine_winners(c::Card)
    return length(intersect(c.winning_numbers, c.my_numbers))
end

function score_card(c::Card)
    winners = determine_winners(c)
    return winners == 0 ? 0 : 2^(winners-1)
end

using Memoization

@memoize function score_card2(c::Card)
    winners = determine_winners(c)
    copies = cards[c.i+1:c.i+winners]
    if length(copies) == 0
        return 1
    else
        return 1 + sum(map(score_card2, copies))
    end
end

input = string.(split("""Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11""","\n"))

input = readlines(open("src/inputs/day4.txt"))

cards = parse_card.(input)

sum(score_card.(cards))

using BenchmarkTools
@btime sum(score_card2.(cards))
