get_dvd_map() {
    local iso_image="$1"
    local category = "$2"
    
    #! Desplazamos 2 posiciones  
    shift 2
    local chapters=("$@")

    MIGRATE_PATH="$RUN_DIR/linux-csv-to-mp4/iso/$category/$iso_image.iso"
    
    dvd_map=()
    current_title=0
    current_chapter=0

    while IFS= read -r line 
        do
            if [[ "$line" == "Title:"* ]]; then
                current_chapter=0
                ((current_title++))
            
            elif [[ "$line" == *"Chapter"* ]]; then

                IFS=" " read -r -a parts <<< $line

                if [[ ! "${parts[2]}" =~ ^00:00:0[0-4] ]]; then                    
                        ((current_chapter++))
                        dvd_map+=("-t $current_title -c $current_chapter")
                    fi
            fi

        done < <(lsdvd -c "$MIGRATE_PATH")
    
    # echo "ISO en tratamiento: ${iso_image}"
    echo "Cantidad en chapters: ${#chapters[@]}"
    echo "Cantidad en dvd_map: ${#dvd_map[@]}"

    # count=${#chapters[@]}

    # for ((i=1; i<count; i++)); do
    #     echo "Elemento $i: ${chapters[$i]}"
    # done

}


extract_chapters() {
    local iso_path="$1"
    local mp4_path="$2"
    local title_chapter="$3"
    local preset="$4"

    HandBrakeCLI -i "$iso_path" -o "$mp4_path" $title_chapter --preset="$preset"

}