validate_arrays_sync() {
    local count_dvd_map="$1"
    local count_chapter_list="$2"
    local count_season_list="$3"
    local count_project_list="$4"

if [[ "$count_chapter_list" -ne "$count_dvd_map" || \
      "$count_season_list"  -ne "$count_dvd_map" || \
      "$count_project_list" -ne "$count_dvd_map" ]]; then
          return 1
    fi
    
    return 0
}