

# Archivo de configuración
source ./etc/config.sh

# Obtener el último archivo en el directorio
ULTIMO_ARCHIVO=$(ls -lrt | tail -1)

# Verificar si el último archivo ya ha sido procesado
if ! grep -q "$ULTIMO_ARCHIVO" historial_archivos.hist; then
    cp "$ULTIMO_ARCHIVO" "$EPG_TMP_DIR"
    echo "$ULTIMO_ARCHIVO" >> historial_archivos.hist
else
    echo "El archivo $ULTIMO_ARCHIVO ya ha sido procesado anteriormente."
fi

# Decodificar archivo
./parse_ebm_log.pl -x upf_ebm_event_specification.xml -f "$EVENT_FILE" > "$EPG_OUT_DIR/$EVENT_FILE_usr.txt"



