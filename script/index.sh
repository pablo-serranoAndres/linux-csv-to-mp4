#!/bin/bash

SERVICES_PATH="$HOME/dev/linux-csv-to-mp4/script/services" 

source ./.env
source $SERVICES_PATH/get_category_from_file.sh
source $SERVICES_PATH/read_csv_file.sh
source $SERVICES_PATH/process_dvd_chapters.sh
source $SERVICES_PATH/echo_functions.sh
source $SERVICES_PATH/extract_chapters.sh
source $SERVICES_PATH/ensure_iso_exists.sh
source $SERVICES_PATH/delete_iso.sh

source $SERVICES_PATH/validations/check_directories.sh
source $SERVICES_PATH/validations/is_chapter_valid.sh
source $SERVICES_PATH/validations/validate_arrays_sync.sh
source $SERVICES_PATH/validations/iso_file_exists.sh
source $SERVICES_PATH/validations/clean_dependencies.sh
source $SERVICES_PATH/validations/check_dependencies.sh

BASE_DIR="$RUN_DIR/linux-csv-to-mp4"
MIGRATE_DIR="$BASE_DIR/files-to-migrate"
ISO_DIR="$BASE_DIR/iso"
TMP_DIR="$BASE_DIR/tmp"
BACKUP_DIR="$BASE_DIR/backup-csv"

check_directories
check_dependencies

for file_path in "$MIGRATE_DIR"/*; do 
    # Validamos que realmente sea un archivo (por si la carpeta está vacía)
    [[ -e "$file_path" ]] || continue

    file=$(basename "$file_path")

    category=$(get_category_from_file "$file")

    read_csv_file "$file" "$category"

    # Pasar fichero a backup
    move_to_backup 
    
done

clean_dependencies