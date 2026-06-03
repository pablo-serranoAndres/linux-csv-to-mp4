clean_dependencies() {
    local dependencies=("genisoimage")

    for dep in "${dependencies[@]}"; do
        echo "🧹 Eliminando dependencia: $dep..."
        sudo apt-get remove -y "$dep"
    done
}