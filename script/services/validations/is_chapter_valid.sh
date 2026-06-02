is_chapter_valid() {
    local line="$1"

    if [[ "$line" == *"Length: 00:00:00"* || \
          "$line" == *"Length: 00:00:01"* || \
          "$line" == *"Length: 00:00:02"* || \
          "$line" == *"Length: 00:00:03"* || \
          "$line" == *"Length: 00:00:04"* ]]; then
        return 1
    fi
    return 0
}