EPG_DIR="prguepgu01"
BIN="./bin"
EPG_OUT_DIR="./txt"
EPG_TMP_DIR="./tmp"
AWK_DIR="liberty/awk"
EVENT_FILE="binario.txt"

# Directorio de logs (relativo al directorio actual)
LOG_DIR="./log"

# Nombre base del archivo de log
LOG_BASE="log"

# Función para manejar errores y registrarlos en el archivo de registro
handle_error() {
    local message="$1"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] Error: $message" >> "$LOG_FILE"
    exit 1
}

# Función para obtener el nombre del archivo de log con marca de tiempo
get_log_filename() {
    local timestamp=$(date "+%Y%m%d%H%M%S")
    echo "$LOG_DIR/$LOG_BASE_$timestamp.log"
}

