read_csv_file() {
    local file=$1
    
    local chapters=()
    local iso_image=""

    MIGRATE_PATH="/home/pablo/dev/linux-csv-to-mp4/files-to-migrate"

    while IFS="," read -r human_project_name project_name og_file season_id title order file_name || [ -n "$file_name" ];
        do

            if [ "$og_file" == "og_file" ] ; then 
                continue
            fi

            if [ "$iso_image" == "" ]; then
                iso_image=$og_file
            fi

            if [ "$iso_image" != "$og_file" ]; then
                # echo "ISO: $iso_image"

                # for ((i=0; i<${#chapters[@]}; i++)); do
                #     echo "Iteration ${chapters[i]}"
                # done

                get_dvd_map "${chapters[@]}"
                
                iso_image=$og_file
                chapters=()

            fi

        chapters+=("$file_name")

        done < $MIGRATE_PATH/$file

        get_dvd_map $chapters

        # echo "ISO: $iso_image"
        
        # for ((i=0; i<${#chapters[@]}; i++)); 
        # do
        #     echo "Iteration ${chapters[i]}"
        # done
}

