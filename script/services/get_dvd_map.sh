get_dvd_map() {
    local iso_image="$1"
    local category="$2"
    local content_name="$3"
    
    #! Desplazamos 3 posiciones  
    shift 3
    declare -n chapters_list="$1"
    declare -n seasons_list="$2"

    MIGRATE_PATH="$RUN_DIR/linux-csv-to-mp4/iso/$iso_image.iso"
    
    local dvd_map=()
    local current_title=0
    local current_chapter=0

    while IFS= read -r line 
        do
            if [[ "$line" == "Title:"* ]]; then
                current_chapter=0
                ((current_title++))
            
            elif [[ "$line" == *"Chapter"* ]]; then

                if [[ "$line" != *"Length: 00:00:00"* && \
                  "$line" != *"Length: 00:00:01"* && \
                  "$line" != *"Length: 00:00:02"* && \
                  "$line" != *"Length: 00:00:03"* && \
                  "$line" != *"Length: 00:00:04"* ]]; then
                    
                    ((current_chapter++))
                    dvd_map+=("-t $current_title -c $current_chapter")
                fi
            fi
# Al poner '2>/dev/null' al final, ese cartelote gigante desaparece para siempre
        done < <(lsdvd -c "$MIGRATE_PATH" 2>/dev/null)
    
    count_dvd_map=${#dvd_map[@]}
    count_chapter_list=${#chapters_list[@]}
    count_season_list=${#seasons_list[@]}

    # if [[ "$count_chapter_list" -ne "$count_dvd_map" || \
    #       "$count_chapter_list" -ne "$count_season_list" || \
    #       "$count_season_list" -ne "$count_dvd_map" ]]; then

    #     echo_error "Error de sincronización: Los arrays no coinciden en tamaño."
    
    # else 

    #     echo "Analizando pista: $iso_image"
    #     echo "Numero de capitulos detectados (dvd_map[]): $count_dvd_map"
    #     echo "Numero de capitulos almacenados (chapters_list[]): $count_chapter_list"
    #     echo "Numero de temporadas  (seasons_list[]): $count_season_list"
    #     echo ""

    #     echo "----------------------------------------------"

    #     echo "DVD_MAP:"
    #     for ((i=0; i<count_dvd_map; i++)); do
    #         echo "${dvd_map[$i]}"
    #     done

    #     echo "++++++++++++++++++++++++++++++++"


    #     echo "CHAPTERS:"
    #     for ((i=0; i<count_chapter_list; i++)); do
    #         echo "${chapters_list[$i]}"    
    #     done

    #     echo "++++++++++++++++++++++++++++++++"


    #     echo "SEASONS:"
    #     for ((i=0; i<count_season_list; i++)); do
    #         echo "${seasons_list[$i]}"    
    #     done

    #     echo "++++++++++++++++++++++++++++++++"
        
    #     fi
    if [[ "$count_chapter_list" -ne "$count_dvd_map" || \
          "$count_chapter_list" -ne "$count_season_list" || \
          "$count_season_list" -ne "$count_dvd_map" ]]; then 

        echo "Procesando la imagen: $iso_image"
        echo_error "Error de sincronización: Los arrays no coinciden en tamaño."
        echo "   -> DVD Map:     ${#dvd_map[@]} elementos"
        echo "   -> Capítulos:   ${#chapters_list[@]} elementos"
        echo "   -> Temporadas:  ${#seasons_list[@]} elementos"
    
    else
        count=${#chapters_list[@]}

        echo "$iso_image - 🚀 Todo alineado. Procesando $count elementos..."
        echo ""

        for ((i=0; i<count; i++)); do
            extract_chapters "$iso_image" "${chapters_list[$i]}" "${dvd_map[$i]}" "$content_name" "${seasons_list[$i]}" "$category"
        done

    fi

}

extract_chapters() {
    local iso_image="$1"
    local mp4_name=$(echo "$2" | tr -d '\r')
    local map_item="$3"
    local content_name="$4"
    local season_id="$5"
    local category="$6"

    if [[ "$season_id" == "NULL" ]]; then
        local mp4_dir="$RUN_DIR/linux-csv-to-mp4/uploads/movies/$category/$content_name/scenes"

    else 
        local mp4_dir="$RUN_DIR/linux-csv-to-mp4/uploads/series/$category/$content_name/seasons/$season_id/"

    fi

    mkdir -p "$mp4_dir"

    local mp4_path="$mp4_dir/${mp4_name}.mp4"

    local iso_path="$RUN_DIR/linux-csv-to-mp4/iso/$iso_image.iso"

    # echo "iso_path: $iso_path"
    # echo "mp4_path: $mp4_path"
    # echo "map_item: $map_item"

    HandBrakeCLI -i $iso_path -o $mp4_path $map_item --preset="$PRESET" </dev/null

    # HandBrakeCLI -i $iso_path -o $mp4_path $map_item --preset="$PRESET"
    

}