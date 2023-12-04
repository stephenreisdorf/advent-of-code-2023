sample_input = string.(split("""467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...\$.*....
.664.598..""", "\n"))

input = readlines(open("src/inputs/day3.txt"))

string_to_vec(s) = only.(string.(split(s, "")))

parse_input(input) = mapreduce(permutedims, vcat, string_to_vec.(input))

sample_schematic = parse_input(sample_input)
schematic = parse_input(input)

is_number(c) = c in "01234567890"
is_symbol(c) = !is_number(c) & (c != '.')
is_potential_gear(c) = c == '*'
is_invalid(i, nrows, ncols) = (i[1] < 1) | (i[2] < 1) | (i[1] > nrows) | (i[2] > ncols)

get_next(i, nrows) = i[2] == nrows ? CartesianIndex(i[1] + 1, 1) : i + CartesianIndex(0,1)

function get_valid_adjacent(schematic, i)
    nrows = size(schematic)[1]
    ncols = size(schematic)[2]
    adjacent_i = [
        i + CartesianIndex(0,1),
        i + CartesianIndex(1,0),
        i + CartesianIndex(0,-1),
        i + CartesianIndex(-1,0),
        i + CartesianIndex(1,1),
        i + CartesianIndex(1,-1),
        i + CartesianIndex(-1,1),
        i + CartesianIndex(-1,-1)
    ]
    valid_adjacent_i = filter(x->!is_invalid(x, nrows, ncols), adjacent_i)
    return valid_adjacent_i
end

function is_symbol_adjacent(schematic, i)
    valid_adjacent_i = get_valid_adjacent(schematic, i)
    return any([ is_symbol(schematic[ai]) for ai in valid_adjacent_i ])
end

function find_potential_gears(schematic, i)
    valid_adjacent_i = get_valid_adjacent(schematic, i)
    return filter(i->is_potential_gear(schematic[i]), valid_adjacent_i)
end

function find_part_numbers(schematic)
    i = CartesianIndex(1,1)
    nrows = size(schematic)[1]
    ncols = size(schematic)[2]
    numbers = []
    gears = Dict()
    while i[1] <= ncols
        x = x = schematic[i]
        if is_number(x)
            is_part_number = false
            is_part_number = is_part_number | is_symbol_adjacent(schematic, i)
            n = [ x ]
            potential_gears = Set(find_potential_gears(schematic, i))
            i = get_next(i, nrows)
            x = schematic[i]
            while is_number(x) & (i[2] != 1)
                append!(n, x)
                is_part_number = is_part_number | is_symbol_adjacent(schematic, i)
                union!(potential_gears, find_potential_gears(schematic, i))
                i = get_next(i, nrows)
                x = schematic[i]
            end
            if is_part_number
                num = parse(Int, reduce(*, n))
                append!(numbers, num)
                for g in collect(potential_gears)
                    haskey(gears, g) ? append!(gears[g], num) : gears[g] = [ num ]
                end
            end
        end
        i = get_next(i, nrows)
    end
    return [ numbers, gears ]
end

result = find_part_numbers(sample_schematic)
sum(result[1])
sum(map(x->x[1]*x[2], values(filter(x-> length(x[2]) == 2, result[2]))))

result = find_part_numbers(schematic)
sum(result[1])
sum(map(x->x[1]*x[2], values(filter(x-> length(x[2]) == 2, result[2]))))

function adjacent_to_two_numbers(schematic, i)
    nrows = size(schematic)[1]
    ncols = size(schematic)[2]
    adjacent_i = [
        i + CartesianIndex(0,1),
        i + CartesianIndex(1,0),
        i + CartesianIndex(0,-1),
        i + CartesianIndex(-1,0),
        i + CartesianIndex(1,1),
        i + CartesianIndex(1,-1),
        i + CartesianIndex(-1,1),
        i + CartesianIndex(-1,-1)
    ]
    valid_adjacent_i = filter(x->!is_invalid(x, nrows, ncols), adjacent_i)
    println(valid_adjacent_i)
    return sum([ is_number(schematic[ai]) for ai in valid_adjacent_i ]) == 2
end

function is_gear(schematic, i)
    c = schematic[i]
    condition_1 = c == '*'
    condition_2 = adjacent_to_two_numbers(schematic, i)
    println("Condition 1: $condition_1")
    println("Condition 2: $condition_2")
    return condition_1 & condition_2
end

is_gear(sample_schematic, CartesianIndex(2,4))

sample_schematic[CartesianIndex(2,4)]