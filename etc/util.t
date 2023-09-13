# Directorios proceso
LOG_DIR=$HOME_PROC_DIR/logs

# Nombre base del archivo de log
LOG_BASE="log_"

# Función para manejar errores y registrarlos en el archivo de registro
handle_error() {
    local message="$1"
    local log_file="$2"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] Error: $message" >> "$log_file"
    exit 1
}

handle_info() {
    local message="$1"
    local log_file="$2"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] Info: $message" >> "$log_file"
}

# Función para obtener el nombre del archivo de log con marca de tiempo
get_log_filename() {
    local timestamp=$(date "+%Y_%m_%_d")
    echo "$LOG_DIR/$LOG_BASE$timestamp.log"
}