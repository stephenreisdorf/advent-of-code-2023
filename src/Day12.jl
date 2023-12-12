row = "???.### 1,1,3"

function parse_row(row)
    s = split(row)
    return s[1], parse.(Int, split(s[2], ","))
end
condition_record, groups = parse_row(row)

function what_exists_already(condition_record)
    condition_record
end 

known_groups = length.(filter(x->!('?' in x), split(condition_record, ".")))
unknown_secions = filter(x->('?' in x), split(condition_record, "."))

groups
i = findfirst(x->x==3, groups)

