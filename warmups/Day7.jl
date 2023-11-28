sample = """\$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
\$ cd a
\$ ls
dir e
29116 f
2557 g
62596 h.lst
\$ cd e
\$ ls
584 i
\$ cd ..
\$ cd ..
\$ cd d
\$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k""";


struct File
    name::String
    size::Integer
end

mutable struct Directory
    name::String
    directories::Vector{Directory}
    files::Vector{File}
    parent
end

is_command(c) = startswith(c, "\$") ? true : false
is_ls(c) = c == "\$ ls"
is_cd(c) = startswith(c, "\$ cd")
parse_cd(c) = c[6:end]

function add_to_directory(l, working_directory)
    tokens = split(l, " ")
    if tokens[1] == "dir"
        push!(working_directory.directories, Directory(tokens[2], Vector{Directory}[], Vector{File}[], working_directory))
    else
        push!(working_directory.files, File(tokens[2], parse(Int, tokens[1])))
    end
end

function parse_command(commands, working_directory)
    c = commands[1]
    println(c)
    remaining_commands = commands[2:end]
    if is_cd(c)
        new_directory_name = parse_cd(c)
        if new_directory_name == ".."
            new_directory = working_directory.parent
        else
            new_directory = only(filter(x -> x.name == parse_cd(c), working_directory.directories))
        end
        return [ commands[2:end], new_directory]
    elseif is_ls(c)
        while !is_command(remaining_commands[1])
            add_to_directory(remaining_commands[1], working_directory)
            remaining_commands = remaining_commands[2:end]
            if length(remaining_commands) == 0
                return [ remaining_commands, working_directory ]
            end
        end
        return [ remaining_commands, working_directory ]
    else
        println("Something Else")
    end
end

function build_tree()
    root = Directory("/", Vector{Directory}[], Vector{File}[], Nothing)
    remaining_commands = commands
    working_directory = root
    i = 1
    while (length(remaining_commands) > 0) & (i < 10)
        print(remaining_commands)
        results = parse_command(remaining_commands, working_directory)
        remaining_commands = results[1]
        working_directory = results[2]
        i = i+1
    end
    return root
end

function sum_tree(d)
    total = 0
    if length(d.files) > 0
        total = total + sum([ f.size for f in d.files ])
    end
    if length(d.directories) > 0
        total = total + sum([ sum_tree(sub) for sub in d.directories ])
    end
    println("At $(d.name): Current Total: $total")
    return total
end

commands = readlines(open("warmups/inputs/day7.txt"))
root = build_tree()
sum_tree(root)
