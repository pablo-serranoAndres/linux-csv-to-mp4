echo_error() {
    local error_message="$1"
    
    echo -e "\033[0;31m${error_message}\033[0m" >&2

}

highlight_echo() {
    local highlight_message="$1"

    NEGRO='\e[1;30m'

    echo -e "'\e[43m'${NEGRO}${highlight_message}\e[0m" >&2
    
}