source /liberty/etc/config.sh 


LOG_FILE="$(get_log_filename)"


# output_variable=$(bash /liberty/shell/decoder_process.sh 2>&1)

# if [ $? -ne 0 ]; then
#     handle_error "Error durante el proceso de decodificación."
# fi



output_variable=$(bash /liberty/shell/parse_and_insert.sh 2>&1)

# Verifica si hubo un error en la ejecución
if [ $? -ne 0 ]; then
    handle_error "$output_variable" "$LOG_FILE"
fi

