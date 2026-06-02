extract_chapters() {
    local iso_image="$1"
    local mp4_name=$(echo "$2" | tr -d '\r')
    local map_item="$3"
    local content_name="$4"
    local season_id="$5"
    local category="$6"

    if [[ "$season_id" == "NULL" ]]; then
        local mp4_dir="$UPLOAD_DIR/movies/$category/$content_name/scenes"

    else 
        local mp4_dir="$UPLOAD_DIR/series/$category/$content_name/seasons/$season_id/"

    fi

    mkdir -p "$mp4_dir"

    local mp4_path="$mp4_dir/${mp4_name}.mp4"
    local iso_path="$RUN_DIR/linux-csv-to-mp4/iso/$iso_image.iso"

    HandBrakeCLI -i $iso_path -o $mp4_path $map_item --preset="$PRESET" </dev/null
}