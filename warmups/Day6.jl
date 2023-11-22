using Pkg; Pkg.add("StatsBase");
using StatsBase

function find_marker(s, pos)
    check = length(countmap(s[pos-3:pos]))
    return check == 4 ? pos : find_marker(s, pos+1)
end

find_marker("bvwbjplbgvbhsrlpgdmjqwftvncz", 4)
find_marker("nppdvjthqldpwncqszvftbrmjlhg", 4)
find_marker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 4)
find_marker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 4)

signal = readlines(open("warmups/inputs/day6.txt"))[1]
find_marker(signal,4)

function find_marker2(s, pos)
    check = length(countmap(s[pos-13:pos]))
    return check == 14 ? pos : find_marker2(s, pos+1)
end

find_marker2("mjqjpqmgbljsphdztnvjfqwrcgsmlb",14)
find_marker2("bvwbjplbgvbhsrlpgdmjqwftvncz",14)
find_marker2("nppdvjthqldpwncqszvftbrmjlhg",14)
find_marker2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",14)
find_marker2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw",14)

find_marker2(signal,14)
