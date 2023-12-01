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
sample2 = """two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen"""

sample_input2 = string.(split(sample2, "\n"))

function text_to_num(s)
    s = replace(s, "one"=>"one1one")
    s = replace(s, "two"=>"two2two")
    s = replace(s, "three"=>"three3three")
    s = replace(s, "four"=>"four4four")
    s = replace(s, "five"=>"five5five")
    s = replace(s, "six"=>"six6six")
    s = replace(s, "seven"=>"seven7seven")
    s = replace(s, "eight"=>"eight8eight")
    s = replace(s, "nine"=>"nince9nine")
    return s
end

calibrate(text_to_num(test2))
text_to_num.(sample_input2)
calibrate.(text_to_num.(sample_input2))
sum(calibrate.(text_to_num.(sample_input2)))
sum(calibrate.(text_to_num.(input)))
