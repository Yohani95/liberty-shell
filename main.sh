source ./etc/config.sh


LOG_FILE="$(get_log_filename)"


./shell/decoder_process.sh 2>> "$LOG_FILE"

# Verificar si ocurrieron errores en el proceso de decodificación y registrarlos en el log
if [ $? -ne 0 ]; then
    handle_error "Error durante el proceso de decodificación."
fi

./shell/parse_and_insert.sh 2>> "$LOG_FILE"

# Verificar si ocurrieron errores en el proceso principal y registrarlos en el log
if [ $? -ne 0 ]; then
    handle_error "Error durante la ejecución del proceso principal."
fi