function parse_input(input)
    first_split = string.(split(input, "\n\n"))
    directions = first_split[1]
    raw_map = string.(split(first_split[2], "\n"))
    return directions, raw_map
end

function parse_map_element(i)
    x = string.(split(i, " = "))[1]
    y = string.(split(replace(string.(split(i, " = "))[2], "(" => "", ")" => "", " " => ""), ","))
    return Dict((x, "L") => y[1], (x, "R") => y[2])
end

function run_directions(directions, m, start_l, end_ls)
    f(l, d) = reduce(merge, parse_map_element.(m))[(l, d)]
    l = start_l
    i = 0
    while !(l in end_ls)
        di = (i % length(directions)) + 1
        d = string(directions[di])
        i += 1
        l = f(l, d)
    end
    println("Got from $start_l to $l in $(i)")
    return i
end

input = """RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)"""

directions, m = parse_input(input)
run_directions(directions, m, "AAA", ["ZZZ"])

input = join(readlines(open("src/inputs/day8.txt")), "\n")
directions, m = parse_input(input)
run_directions(directions, m, "AAA", ["ZZZ"])

input = """LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)"""

directions, m = parse_input(input)
m2 = reduce(merge, parse_map_element.(m))
starts = filter(x->x[end] == 'A', map(x->x[1][1], collect(m2)))
ends = filter(x->x[end] == 'Z', map(x->x[1][1], collect(m2)))

run_directions(directions, m, starts[1], ends)
lcm(map(x->run_directions(directions, m, x, ends), starts))
