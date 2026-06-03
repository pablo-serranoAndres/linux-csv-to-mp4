move_to_backup() {
    local file="$1"

    local original_path="$MIGRATE_DIR/$file"
    local backup_path="$BACKUP_DIR/" 

    mv "$original_path" "$backup_path"
    
}