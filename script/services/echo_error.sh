echo_error() {
    local error_message="$1"
    
    echo -e "\033[0;31m${error_message}\033[0m" >&2

}