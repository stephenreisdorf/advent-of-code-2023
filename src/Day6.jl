using Roots

distance_fn(total_time) = f(t_hold) = t_hold*(total_time-t_hold)

function number_of_ways(time, record)
    distance = distance_fn(time)
    ways = distance.(0:time)
    winning_ways = filter(x->x > record, ways)
    return length(winning_ways)
end

number_of_ways(7, 9)

function parse_races(input)
    times, records = split.(map(x -> split(x, ":")[2], input))
    return zip(parse.(Int, times), parse.(Int, records)) |> collect
end

function parse_input2(input)
    times, records = split.(map(x -> split(x, ":")[2], input))
    time = parse(Int, prod(times))
    record = parse(Int, prod(records))
    return time, record
end

# Sample
input = string.(split("""Time:      7  15   30
Distance:  9  40  200""", "\n"))

races = parse_races(input)
prod(map(x->number_of_ways(x[1], x[2]), sample_races))

time, record = parse_input2(input)
f = distance_fn(time)
zeroes = find_zeros(x -> f(x)- record, (0, time))
floor(Int, zeroes[2]) - ceil(Int, zeroes[1]) + 1

# Actual
input = string.(split("""Time:        44     89     96     91
Distance:   277   1136   1890   1768""", "\n"))

races = parse_races(input)
prod(map(x->number_of_ways(x[1], x[2]), races))

time, record = parse_input2(input)
f = distance_fn(time)
zeroes = find_zeros(x -> f(x)- record, (0, time))
floor(Int, zeroes[2]) - ceil(Int, zeroes[1]) + 1
