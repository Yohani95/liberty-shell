. $3
. $4
LOG_FILE=$5 

CURRENT_DATE=`date '+%Y-%m-%d'`
PROCESSED_FILES=processed_$2_$CURRENT_DATE.hist

handle_info "Process: [getfile_epgu.sh], Create record file [${HIST_DIR}/${PROCESSED_FILES}] if not exist" $LOG_FILE
if [ ! -f $HIST_DIR/$PROCESSED_FILES ]
then
	touch $HIST_DIR/$PROCESSED_FILES
fi

LAST_FILE="`ls -t $1/$2 | head -1`"

handle_info "Process: [getfile_epgu.sh], Processing last file [${LAST_FILE}], Directory:  [${1}/${2}]" $LOG_FILE
if [ "`grep -c $LAST_FILE $HIST_DIR/$PROCESSED_FILES`" -eq 0 ]
then
        cp $1/$2/$LAST_FILE $BIN_DIR
        handle_info "Process: [getfile_epgu.sh], Decoding file [${LAST_FILE}], Directory:  [${BIN_DIR}]" $LOG_FILE
		
		perl /$TOOL_DIR/parse_ebm_log.pl -x $TOOL_DIR/upf_ebm_event_specification.xml -f $BIN_DIR/$LAST_FILE> $TXT_DIR/$LAST_FILE.txt
        
		echo $LAST_FILE >>$HIST_DIR/$PROCESSED_FILES
else
        handle_info "Process: [getfile_epgu.sh], File [${LAST_FILE}], Processed already" $LOG_FILE
fi