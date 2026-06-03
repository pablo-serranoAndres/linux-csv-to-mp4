check_dependencies() {
    local dependencies=("genisoimage")

    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            echo "📥 Instalando dependencia faltante: $dep..."
            sudo apt-get update
            sudo apt-get install -y "$dep"
        fi
    done
}