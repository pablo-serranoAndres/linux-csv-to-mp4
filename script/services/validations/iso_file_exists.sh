iso_file_exists() {
    local dvd_name="$1"

    local ISO_FILE_PATH="$ISO_DIR/$dvd_name.iso"

    if [[ -f $ISO_FILE_PATH ]]; then
        return 0
    else 
        return 1
    fi

}