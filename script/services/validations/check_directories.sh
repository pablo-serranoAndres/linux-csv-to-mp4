check_directories() {
    local directories=("$BASE_DIR" \
    "$MIGRATE_DIR" \
    "$ISO_DIR" \
    "$TMP_DIR" \
    "$BACKUP_DIR" \
    "$UPLOAD_DIR" \
    )
    
    for dir in "${directories[@]}"; do
        mkdir -p "$dir"
    done

    echo "📂 Estructura de directorios verificada y lista."
}