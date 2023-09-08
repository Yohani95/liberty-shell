#!/bin/bash

# Incluye el archivo de configuración
source /liberty/etc/config.sh

# Obtiene el nombre del archivo de log con marca de tiempo
LOG_FILE="$(get_log_filename)"

# Función para ejecutar un comando y manejar errores
# Función para ejecutar un comando y manejar errores
run_command() {
    local command="$1"
    local log_file="$2"
    # Ejecuta el comando y captura la salida en una variable
    output_variable=$(eval "$command" 2>&1)
    if [ $? -ne 0 ] && [ -n "$output_variable" ]; then
        # Registra el error en el archivo de log
        handle_error "$output_variable" "$log_file"
        exit 1
    fi
}


# Continuar con el siguiente comando
TEXT_FILE="$EPG_OUT_DIR/$EVENT_FILE"
run_command "awk -v epg='$EPG_DIR' -f '$AWK_DIR/trafico_ap_usr.awk' '$TEXT_FILE' > '$EPG_TMP_DIR/data_file.txt'" "$LOG_FILE"

# Continuar con el siguiente comando
DATA_FILE="$EPG_TMP_DIR/data_file.txt"
run_command "awk -f '$AWK_DIR/sql_trafico_ap_usr.awk' '$DATA_FILE' > '$EPG_TMP_DIR/sql_insert.sql'" "$LOG_FILE"

# Continuar con el siguiente comando
run_command "mysql -h $HOST -P $PORT -u root -p'$PASS' $DB < '$EPG_TMP_DIR/sql_insert.sql'" "$LOG_FILE"
