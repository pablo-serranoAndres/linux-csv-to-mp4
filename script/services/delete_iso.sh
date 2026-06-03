delete_iso() {
    local iso_image="$1"

    rm -f "${ISO_DIR}/$iso_image.iso"
}