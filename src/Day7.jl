import Base.isless
using StatsBase

struct Card
    c::Char
end

# Changed position of J for Part 2
score_card(card::Card)::Int = findfirst(card.c, "J23456789TQKA")
Base.:isless(x::Card, y::Card) = score_card(x) < score_card(y)

struct Hand
    cards::Vector{Card}
end

parse_hand(h) = Hand(Card.(only.(split(h, ""))))
determine_type(h::Hand) = sort(filter(x->x>1, collect(values(countmap(h.cards)))))
score_type(h::Hand) = Dict([] => 1, [2] => 2, [2,2] => 3, [3] => 4, [2,3] => 5, [4] => 6, [5] => 7)[determine_type(h)]

get_cards(h::Hand, of_a::Int) = sort(map(x->x[1], filter(x->x[2] == of_a, sort(collect(countmap(h.cards)), by=x->x[2]))))

determine_type2(h::Hand) = sort(filter(x->x>1, collect(values(countmap(filter(x->x!=Card('J'),h.cards))))))
function score_type2(h::Hand)
    t = determine_type2(h)
    js = Card('J') in h.cards ? countmap(h.cards)[Card('J')] : 0
    if length(t) > 0
        t[end] = t[end] + js
    elseif js > 0
        t = [ 1 + js ]
    end
    return Dict([] => 1, [2] => 2, [2,2] => 3, [3] => 4, [2,3] => 5, [4] => 6, [5] => 7, [6] => 7)[t]
end

# Changed score_type function for part 2
function Base.isless(x::Hand, y::Hand)
    r1 = score_type2(x)
    r2 = score_type2(y)
    if r1 == r2
        remaining1 = x.cards
        remaining2 = y.cards
        bv = remaining1 .!= remaining2
        if sum(bv) == 0
            return false
        else
            return remaining1[bv][1] < remaining2[bv][1]
        end
    else
        return r1 < r2
    end
end

function parse_input(input::Vector{String})
    round = split.(input)
    hands = parse_hand.(map(x->x[1], round))
    bids = parse.(Int, map(x->x[2], round))
    return hands, bids
end

input = """32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483""" |> x-> string.(split(x, "\n"))

hands, bids = parse_input(input)
ranks = invperm(sortperm(hands))
sum(bids .* ranks)

input = readlines(open("src/inputs/day7.txt"))
hands, bids = parse_input(input)
ranks = invperm(sortperm(hands))
sum(bids .* ranks)
