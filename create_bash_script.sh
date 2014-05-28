#!/bin/bash
if [ "$1" = "-t" ]; then 
 TODAY=`date`
 YEAR=`echo $TODAY | awk '{ print $6 }'`
 MONTH=`echo $TODAY | awk '{ print $2 }'`
 DAY=`echo $TODAY | awk '{ print $3 }'`
 echo "#!/bin/bash" > "script_"$YEAR"_"$MONTH"_DAY.sh"
elif [ $1 ]; then
 echo "#!/bin/bash" > $1
 chmod +x $1
 joe $1
fi