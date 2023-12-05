function build_range(ss)
    range_start = ss[1]
    range_end = ss[1] + ss[3] - 1
    return collect(range_start:range_end)
end

function build_single_map(s)
    ss = parse.(Int, split(s))
    dest_range = collect(ss[1]:ss[1] + ss[3] - 1)
    source_range = collect(ss[2]:ss[2] + ss[3] - 1)
    return source_range, dest_range
end

function build_map(ms)
    maps = build_single_map.(ms)
    concat(x, y) = [ x ; y ]
    source_range = reduce(concat, map(x->x[1], maps))
    dest_range = reduce(concat, map(x->x[2], maps))
    return f(x) = x in source_range ? dest_range[ findfirst(i -> i == x, source_range) ] : x
end

input = read(open("src/samples/day5.txt"), String)
input = read(open("src/inputs/day5.txt"), String)

input_split = split(input, "\n\n")
seeds = parse.(Int, split(split(input_split[1], ":")[2]))

x = seeds
for is in input_split[2:end]
    print(split(is, ":\n")[1])
    ms = string.(split(split(is, ":\n")[2], "\n"))
    f = build_map(ms)
    x = map(f, x)
    print(x)
end
minimum(x)
