#!/bin/bash

SERVICES_PATH="$HOME/dev/linux-csv-to-mp4/script/services" 

source ./.env
source $SERVICES_PATH/get_categorie_from_file.sh
source $SERVICES_PATH/read_csv_file.sh
source $SERVICES_PATH/get_dvd_map.sh
source $SERVICES_PATH/echo_error.sh

ls $RUN_DIR/linux-csv-to-mp4/files-to-migrate/ | while IFS= read -r file
do
    category=$(get_categorie_from_file "$file")

    read_csv_file $file $category
    # get_dvd_map
    
done