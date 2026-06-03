get_category_from_file () {
    local file=$1

    IFS="-" read -r -a parts <<< "$file"

    echo ${parts[0]}
}