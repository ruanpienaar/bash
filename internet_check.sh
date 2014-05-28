#!/bin/bash
host1=google.com
host2=wikipedia.org
#curr_date=`date +"%Y%m%d%H%M"`
#echo -n "${curr_date};"
((ping -W10 -c2 $host1 || ping -W10 -c2 $host2) > /dev/null 2>&1) && echo "up" || (echo "down" && exit 1)