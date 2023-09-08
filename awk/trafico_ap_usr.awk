BEGIN{
	date="";
	field="";
	pos=0;	
	i=0
}
{
	if(match($0,"date")>0) date=substr($0,6,10);
	if(match($0,"EVENT")>0) 
		{
			pos=FNR;
			i=i+1
		}
	else
		{	
			if(FNR>pos && pos>0)
			{
				if(match($0,"time_hour")>0 || match($0,"time_minute")>0 || match($0,"service_id")>0 ||match($0,"service_dl_bytes")>0 || match($0,"service_ul_bytes")>0)
				{
					split($0,t," = ");
					field=t[2]"|"	
				}						
				record[i]=record[i] field;				
				field=""
			}
		}	
}
END{
	for (i in record) 
		{
			print i"|"epg"|"date"|"record[i]
		}
}