BEGIN{
	FS = "|"
}
{
	epg=$2;
	date=$3;
	time_hour=$4;
	time_minute=$5;
	service_id=$6;
	service_dl_bytes=$7;
	service_ul_bytes=$8;
	up_seid=$9;
	datetime=date" "time_hour":"time_minute
		
    print "INSERT INTO trafico_por_aplicacion (epg_epgu, datetime, service_id, service_dl_bytes, service_ul_bytes) VALUES ('" epg "','" datetime "','" service_id "'," service_dl_bytes "," service_ul_bytes ");"
}
END{
}