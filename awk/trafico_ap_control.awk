up_seid,
MSISDN

IMSI

RAT

IMEI

TAC
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
				if(match($0,"msisdn")>0||match($0,"imsi")>0||match($0,"rat")>0||match($0,"imeisv")>0||match($0,"tac")>0)
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