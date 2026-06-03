read_csv_file() {
    local file="$1"
    local category="$2"
    
    local chapters=()
    local seasons=()
    local projects=()
    local dvd_name=""

    while IFS="," read -r project_name og_file season_id file_name || [ -n "$file_name" ]; do

            if [[ "$og_file" == "og_file" ]] ; then 
                continue
            fi

            if [[ "$dvd_name" == "" ]]; then
                dvd_name=$og_file
            fi

            if [[ "$dvd_name" != "$og_file" ]]; then
                process_dvd_chapters "$dvd_name" "$category" chapters seasons projects
                
                dvd_name=$og_file
                
                chapters=()
                seasons=()
                projects=()

            fi

        chapters+=("$file_name")
        seasons+=("$season_id")
        projects+=("$project_name")

        done < "$MIGRATE_DIR/$file"

    if [[ ${#chapters[@]} -gt 0 ]]; then
        process_dvd_chapters "$dvd_name" "$category" chapters seasons projects
    fi
}

