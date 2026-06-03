ensure_iso_exists() {
    local category="$1"
    local dvd_name="$2"

    local hdd_dvd_path="$ORIGIN_DIR/$category/$dvd_name"
    local iso_file_path="$ISO_DIR/$dvd_name.iso"
    local tmp_working_dir="$TMP_DIR/$dvd_name"

    if ! iso_file_exists "$dvd_name"; then
        cp -r "$hdd_dvd_path" "$TMP_DIR/"

           genisoimage \
            -dvd-video \
            -V "$dvd_name" \
            -o "$iso_file_path" \
            "$tmp_working_dir"

    rm -rf "$tmp_working_dir"
    
    fi

    return 0
}