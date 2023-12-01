sample = """1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"""

sample_input = string.(split(sample, "\n"))

test = "1abc2"

nums = "0123456789"

function calibrate(s)
    digits_only = filter(x -> x in nums, s)
    first_and_last = digits_only[begin] * digits_only[end]
    return parse(Int, first_and_last)
end

calibrate(test)
calibrate.(sample_input)

input = readlines(open("src/inputs/day1.txt"))
sum(calibrate.(input))

test2 = "sixrrmlkptmc18zhvninek"

function text_to_num(s)
    s = replace(s, "one"=>"1")
    s = replace(s, "two"=>"2")
    s = replace(s, "three"=>"3")
    s = replace(s, "four"=>"4")
    s = replace(s, "five"=>"5")
    s = replace(s, "six"=>"6")
    s = replace(s, "seven"=>"7")
    s = replace(s, "eight"=>"8")
    s = replace(s, "nine"=>"9")
    return s
end

sum(calibrate.(text_to_num.(input)))
