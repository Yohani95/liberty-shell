CURRENT_DATE=`date '+%Y-%m-%d'`
BIN_FILES="FILES"
PROCESSED_FILES="processed_files_${CURRENT_DATE}.reg"
TOOLS_DIRECTORY="../tools"


LAST_FILE="`ls -t $BIN_FILES | head -1`"


echo "Leyendo ultimo archivo ${LAST_FILE}"
if [ "`grep -c $LAST_FILE $PROCESSED_FILES`" -eq 0 ]
then
        cp $BIN_FILES/$LAST_FILE $TOOLS_DIRECTORY
        #DECODING
        echo $LAST_FILE >>$PROCESSED_FILES
else
        echo "Ultimo archivo ya fue procesado"
fi