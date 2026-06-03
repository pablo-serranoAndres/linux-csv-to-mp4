process_dvd_chapters() {
    local dvd_name="$1"
    local category="$2"
    
    #! Desplazamos 2 posiciones  
    shift 2
    declare -n chapters_list="$1"
    declare -n seasons_list="$2"
    declare -n project_list="$3"
    
    ensure_iso_exists "$category" "$dvd_name"
    
    local iso_image="$dvd_name"
    
    local dvd_map=()
    local current_title=0
    local current_chapter=0    

    while IFS= read -r line 
        do
            if [[ "$line" == "Title:"* ]]; then
                current_chapter=0
                ((current_title++))
            
            elif [[ "$line" == *"Chapter"* ]]; then

                if is_chapter_valid "$line"; then
                    ((current_chapter++))
                    dvd_map+=("-t $current_title -c $current_chapter")
                fi
            fi
        done < <(lsdvd -c "$ISO_DIR/$iso_image.iso" 2>/dev/null)

    if ! validate_arrays_sync "${#dvd_map[@]}" "${#chapters_list[@]}" "${#seasons_list[@]}" "${#project_list[@]}"; then 
        echo_error "Error de sincronización en $iso_image. Los arrays no coinciden en tamaño."
        return 1
    fi

    count=${#chapters_list[@]}

    echo "$iso_image - 🚀 Todo alineado. Procesando $count elementos..."
    echo ""

    for ((i=0; i<count; i++)); do
        extract_chapters "$iso_image" "${chapters_list[$i]}" "${dvd_map[$i]}" "${project_list[$i]}" "${seasons_list[$i]}" "$category"
    done


    delete_iso "$iso_image"
}

