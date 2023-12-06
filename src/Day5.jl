flatten(x) = reduce((x,y) -> [x;y], x)

function build_single_map(s)
    ss = parse.(Int, split(s))
    offset = ss[1] - ss[2]
    a = ss[2]
    b = ss[2] + ss[3] - 1
    inv_a = ss[1]
    inv_b = ss[1] + ss[3] - 1
    interval = a:b
    inv_interval = inv_a:inv_b
    f(x) = x in interval ? x + offset : 0
    invf(x) = x in inv_interval ? x - offset : 0
    return f, invf, [a, b]
end

f, invf, d = build_single_map("50 98 2")

function build_map(ms)
    maps = build_single_map.(ms)
    fs = map(x -> x[1], maps)
    invfs = map(x -> x[2], maps)
    discontinuties = map(x -> x[3], maps)
    g(x) = sum([ f(x) for f in fs])
    invg(x) = sum([ invf(x) for invf in invfs ])
    h(x) = g(x) == 0 ? x : g(x)
    invh(x) = invg(x) == 0 ? x : invg(x)
    return h, invh, flatten(discontinuties)
end

f, invf, d = build_map(["50 98 2", "52 50 48"])
d

function determine_function(input_split)
    f(x) = x
    invf(y) = y
    discontinuities = []
    for is in input_split[2:end]
        ms = string.(split(split(is, ":\n")[2], "\n"))
        g, invg, d = build_map(ms)
        println("$ms : $d : $(invf.(d))")
        append!(discontinuities, invf.(d))
        f = g ∘ f
        invf = invf ∘ invg
    end
    return f, invf, discontinuities
end

input = read(open("src/samples/day5.txt"), String)
input = read(open("src/inputs/day5.txt"), String)

input_split = split(input, "\n\n")

f, invf, discontinuities = determine_function(input_split)
seeds = parse.(Int, split(split(input_split[1], ":")[2]))

minimum(f.(seeds))

A = [ [i[1],i[1]+i[2]] for i in eachcol(reshape(seeds, 2, trunc(Int, length(seeds) / 2))) ]

function find_minimum_in_range(f,R)
    a = R[1]
    b = R[2] - 1
    r = a:b
    checks = [ discontinuities; a; b]
    return minimum(f.(filter(x->x in r, checks)))
end

current_min = f(A[1][1])
for R in A
    new_min =find_minimum_in_range(f, R)
    current_min = minimum([current_min, new_min])
end
current_min
