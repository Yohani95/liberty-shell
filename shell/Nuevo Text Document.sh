source ./etc/config.sh

# Obtener el nombre del archivo de log con marca de tiempo
LOG_FILE="$(get_log_filename)"

# Función para manejar errores y registrarlos en el archivo de registro
handle_error() {
    local message="$1"
    echo "Error: $message" >> "$ERROR_LOG"
    exit 1
}

# Copiar el archivo al directorio temporal y registrar errores
cp "$EVENT_FILE" "$EPG_TMP_DIR" 2>> "$ERROR_LOG" || handle_error "Error al copiar el archivo"

# Decodificar archivo y registrar errores
./parse_ebm_log.pl -x upf_ebm_event_specification.xml -f "$EVENT_FILE" > "$EPG_OUT_DIR/$EVENT_FILE_usr.txt" 2>> "$ERROR_LOG" || handle_error "Error al decodificar el archivo"

# Parsear archivo y registrar errores
TEXT_FILE="$EPG_OUT_DIR/$EVENT_FILE_usr.txt"
awk -v epg="$EPG_DIR" -f "$AWK_DIR/trafico_ap_usr.awk" "$TEXT_FILE" > "$EPG_TMP_DIR/data_file.txt" 2>> "$ERROR_LOG" || handle_error "Error al parsear el archivo"

# Insertar en BD y registrar errores
DATA_FILE="data_file.txt"
awk -f "$AWK_FILE/sql_trafico_ap_usr.awk" "$DATA_FILE=$SCRIPT_FILE" 2>> "$ERROR_LOG" || handle_error "Error al insertar en la base de datos"

# Ejecutar MySQL y registrar errores
mysql -h {host} -u {user} < "$SCRIPT_FILE" 2>> "$ERROR_LOG" || handle_error "Error al ejecutar MySQL"
