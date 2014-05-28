#!/bin/bash

get_config_list()
{
   typeset config_file=$1

   awk -F '[][]' '
      NF==3 && $0 ~ /^\[.*\]/ { print $2 }
   ' ${config_file}
}

# Function : set_config_vars config_file config [var_prefix]
# Purpose  : Set variables (optionaly prefixed by var_prefix) from config in config file
set_config_vars()
{
   typeset config_file=$1
   typeset config=$2
   typeset var_prefix=$3
   typeset config_vars

   echo "File=$config_file config=$config var_prefix=$var_prefix config_vars=$config_vars"

   config_vars=$(
        awk -F= -v Config="${config}" -v Prefix="${var_prefix}" '
        BEGIN {
           Config = toupper(Config);
           patternConfig = "\\[" Config "]";
        }
        toupper($0)  ~ patternConfig,(/\[/ && toupper($0) !~ patternConfig)  {
           if (/\[/ || NF <2) next;
           sub(/^[[:space:]]*/, "");
           sub(/[[:space:]]*=[[:space:]]/, "=");
           print Prefix $0;
        } ' ${config_file} )

   eval "${config_vars}"
}

check_services_up()
{
        for svc in $(get_config_list ${services_file}) do
                echo "--- Configuration [${svc}] ---"
                unset $(set | awk -F= '/^svc_/  { print $1 }') svc_
                set_config_vars ${services_file} ${svc} svc_
                set | grep ^svc_

                service_status=$(svcs -a | grep application | grep "${svc_name}" | awk 'BEGIN { FS=" " } { print $1 }')
                echo $service_status
                echo $svc_name
                if [ "$service_status" != "online" ]; then
                        all_up=0
                        errors="$errors; service $svc_name not running"
                        echo "problem with $svc_name "
                fi
        done
}

check_snmp()
{
        for snmp in $(get_config_list ${snmps_file}) do
                echo "--- Configuration [${snmp}] ---"
                unset $(set | awk -F= '/^snmp_/  { print $1 }') snmp_
                set_config_vars ${snmps_file} ${snmp} snmp_
                set | grep ^snmp_

                val_array=$(snmpwalk -Os -c public -v 2c  ${host}:${port} $snmp_oid | awk 'BEGIN { FS=":" } { print $2 }')

                for val in ${val_array[@]}
                do
                        if [ "$snmp_threshold_operator" = ">" ]; then
                                if [ $val -lt $snmp_threshold_value ]; then
                                        all_up=0
                                        errors="$errors; snmp value for $snmp is $val and less than $snmp_threshold_value"
                                fi
                        elif [ "$snmp_threshold_operator" = "<" ]; then
                                if [ $val -gt $snmp_threshold_value ];
                                then
                                        all_up=0
                                        errors="$errors; snmp value for $snmp is $val and greater than $snmp_threshold_value"
                                fi
                        elif [ "$snmp_threshold_operator" = "=" ]; then
                                if [ $val != $snmp_threshold_value ]; then
                                        all_up=0
                                        errors="$errors; snmp value for $snmp is $val and not $snmp_threshold_value"
                                fi
                        fi
                done
        done
}

host=localhost
port=4000

all_up=1
services_file=$1
snmps_file=$2

check_services_up
check_snmp

if [ "$all_up" != "1" ];
then
        echo "PROBLEMS!!!!!!"
        echo "$errors"
fi

