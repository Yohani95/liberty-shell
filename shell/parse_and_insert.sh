
source /liberty/etc/config.sh


# Parsear archivo
TEXT_FILE="/liberty/txt/$EVENT_FILE"
awk -v epg="$EPG_DIR" -f "/liberty/awk/trafico_ap_usr.awk" "$TEXT_FILE" > "/liberty/temp/data_file.txt"

# Insertar en BD
# DATA_FILE="$EPG_TMP_DIR/data_file.txt"
# awk -f "$AWK_DIR/sql_trafico_ap_usr.awk" "$EPG_TMP_DIR/data_file.txt" > sql.sql

