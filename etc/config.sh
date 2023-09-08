EPG_DIR="prguepgu01"
BIN="./bin"
EPG_OUT_DIR="/liberty/txt"
EPG_TMP_DIR="/liberty/temp"
AWK_DIR="/liberty/awk"
EVENT_FILE="binario.txt"
TMP_STDOUT_FILE="/liberty/logs/stdout.log"
TMP_STDERR_FILE="/liberty/logs/stderr.log"
# Directorio de logs (relativo al directorio actual)
LOG_DIR="/liberty/logs"

# Nombre base del archivo de log
LOG_BASE="log_"

# MySQL
HOST=192.168.1.3
PORT=7075
USER=root
PASS=allware123
DB=liberty

# Función para manejar errores y registrarlos en el archivo de registro
handle_error() {
    local message="$1"
    local log_file="$2"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] Error: $message" >> "$log_file"
    exit 1
}

# Función para obtener el nombre del archivo de log con marca de tiempo
get_log_filename() {
    local timestamp=$(date "+%Y_%m_%_d")
    echo "$LOG_DIR/$LOG_BASE$timestamp.log"
}
