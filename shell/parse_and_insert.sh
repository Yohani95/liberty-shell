. $1
. $2
LOG_FILE=$3 

# Función para ejecutar un comando y manejar errores
run_command() {
    local command="$1"
    local log_file=$3
    # Ejecuta el comando y captura la salida en una variable
    output_variable=$(eval "$command" 2>&1)
    if [ $? -ne 0 ] && [ -n "$output_variable" ]; then
        # Registra el error en el archivo de log
        handle_error "$output_variable" "$log_file"
        exit 1
    fi
}

$latest_file = Get-ChildItem -Path $TXT_DIR | Sort-Object LastWriteTime -Descending | Select-Object -First 1

# Check if a file was found
if [ -n "$latest_file" ]; then
    TEXT_FILE="$latest_file"
    handle_info "The latest file in $TXT_DIR is: $TEXT_FILE" "$LOG_FILE"

    handle_info "Process: [parse_and_insert.sh], Executing: [trafico_ap_usr.awk]" "$LOG_FILE"
    run_command "awk -v epg='$4' -f '$AWK_DIR/trafico_ap_usr.awk' '$TEXT_FILE' > '$EPG_TMP_DIR/data_file.txt'" "$LOG_FILE"

    handle_info "Process: [parse_and_insert.sh], Executing: [sql_trafico_ap_usr.awk]" "$LOG_FILE"
    DATA_FILE="$EPG_TMP_DIR/data_file.txt"
    run_command "awk -f '$AWK_DIR/sql_trafico_ap_usr.awk' '$DATA_FILE' > '$EPG_TMP_DIR/sql_insert.sql'" "$LOG_FILE"

    handle_info "Process: [parse_and_insert.sh], Executing: [mysql insert]" "$LOG_FILE"
    run_command "mysql -h $HOST -P $PORT -u root -p'$PASS' $DB < '$EPG_TMP_DIR/sql_insert.sql'" "$LOG_FILE"
else
    handle_info "No files were found in the directory $TXT_DIR." "$LOG_FILE"
fi
