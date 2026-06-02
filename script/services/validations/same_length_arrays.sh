same_length_arrays() {
    local count_dvd_map="$1"
    local count_chapter_list="$2"
    local count_season_list="$3"

    if [[ "$count_chapter_list" -ne "$count_dvd_map" || \
          "$count_chapter_list" -ne "$count_season_list" || \
          "$count_season_list" -ne "$count_dvd_map" ]]; then 
          return 1
    fi
    return 0
}