sample = """\$ cd /
\$ ls
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
7214296 k"""


struct File
    name::String
    size::Integer
end

struct Directory
    name::String
    directories::Vector{Directory}
    files::Vector{File}
    parent::Directory
end

struct Root
    name::String
    directories::Vector{Directory}
    files::Vector{File}
end

root = Root("/", [], [])

function parse_command(working_directory, commands)
    command = commands[1]
    if startswith(command, "\$ cd")
        directory_name = command[5:end]
        if directory_name == ".."
            return [ working_directory.parent, commands[2:end] ]
        else
            return [ only(filter(x -> x.name == directory_name, working_directory.directories)), commands[2:end] ]
        end
    elseif startswith(command, "\$ ls")
        next_command_index = findfirst(x->x[1] == "\$", commands[2:end])
        commands[2:next_command_index-1]
    end
end
