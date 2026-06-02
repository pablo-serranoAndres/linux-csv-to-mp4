read_csv_file() {
    local file=$1
    local category=$2
    
    local chapters=()
    local seasons=()
    local iso_image=""
    local content_name=""

    MIGRATE_PATH="$RUN_DIR/linux-csv-to-mp4/files-to-migrate"

    while IFS="," read -r project_name og_file season_id file_name || [ -n "$file_name" ];
        do

            if [ "$og_file" == "og_file" ] ; then 
                continue
            fi

            if [ "$iso_image" == "" ]; then
                iso_image=$og_file
                content_name="$project_name"
            fi

            if [ "$iso_image" != "$og_file" ]; then
                get_dvd_map "$iso_image" "$category" "$content_name" chapters seasons
                
                iso_image=$og_file
                content_name="$project_name"
                
                chapters=()
                seasons=()

            fi

        chapters+=("$file_name")
        seasons+=("$season_id")
        # content_name=$project_name

        done < "$MIGRATE_PATH/$file"

    if [[ ${#chapters[@]} -gt 0 ]]; then
        get_dvd_map "$iso_image" "$category" "$content_name" chapters seasons
    fi
}

