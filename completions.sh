_simple_completions() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local suggestions="s1 s2 s3"
    COMPREPLY=( $(compgen -W "${suggestions}" -- "${cur}") )
}

_nested_completions() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local prev="${COMP_WORDS[COMP_CWORD-1]}"

    case "${prev}" in
        "name1"|"name2")
            local suggestions="s1 s2 s3"
            COMPREPLY=( $(compgen -W "${suggestions}" -- "${cur}") )
            return 0
            ;;
        *)
            local suggestions="s1 s2 s3"
            COMPREPLY=( $(compgen -W "${suggestions}" -- "${cur}") )
            return 0
            ;;
    esac
}

# complete -F _simple_completions name
# complete -F _nested_completions name

# Suggest files and directories just like 'ls'
# complete -A file name

# Suggest ONLY directories
# complete -A directory name

# Suggests all executable commands found in the user's $PATH
complete -A command o

# Proxy
# Check via complete -p name
