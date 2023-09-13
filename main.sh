. $HOME/dpi_report/etc/config.conf
. $HOME/dpi_report/etc/util.t

CFG_FILE=$HOME/dpi_report/etc/config.conf
UTIL_FILE=$HOME/dpi_report/etc/util.t
LOG_FILE="$(get_log_filename)"

handle_info "Process: [main], Start process" $LOG_FILE
pids=""
for directory in $EPGU_DIR 
do
	handle_info "Process: [main], Executing: [getfile_epgu.sh], Directory: [${EBM_DIR}/${directory}]" $LOG_FILE
	sh $SHELL_DIR/getfile_epgu.sh $EBM_DIR $directory $CFG_FILE $UTIL_FILE $LOG_FILE &

	handle_info "Process: [main], Executing: [parse_and_insert.sh], Directory: [${EBM_DIR}/${directory}]" $LOG_FILE 
	sh $SHELL_DIR/parse_and_insert.sh $CFG_FILE $UTIL_FILE $LOG_FILE $directory &

	pid=$!
    	pids="$pids $pid" 
done 

for pid in $pids
do
	wait ${pid}
done

handle_info "Process: [main], End of process" $LOG_FILE

