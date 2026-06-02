#!/bin/bash

SERVICES_PATH="$HOME/dev/linux-csv-to-mp4/script/services" 

source ./.env
source $SERVICES_PATH/get_categorie_from_file.sh
source $SERVICES_PATH/read_csv_file.sh
source $SERVICES_PATH/process_dvd_chapters.sh
source $SERVICES_PATH/echo_error.sh
source $SERVICES_PATH/extract_chapters.sh
source $SERVICES_PATH/validations/is_chapter_valid.sh
source $SERVICES_PATH/validations/validate_arrays_sync.sh

BASE_DIR="$RUN_DIR/linux-csv-to-mp4"
MIGRATE_DIR="$BASE_DIR/files-to-migrate"
ISO_DIR="$BASE_DIR/iso"
UPLOAD_DIR="$RUN_DIR/$EXPORT_DIR"

ls $RUN_DIR/linux-csv-to-mp4/files-to-migrate/ | while IFS= read -r file
do
    category=$(get_categorie_from_file "$file")

    read_csv_file $file $category
    
done