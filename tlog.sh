#!/usr/bin/env bash

if [[ "$1" == "" ]]; then
    echo "usage: tlog.sh <options> <keyword>"
    exit 1
fi

D=
args=("$@")
args_filter=()
LOG=

for ((i=0; i<${#args[@]}; i++)); do
    if [[ "${args[$i]}" == "-t" ]]; then
        n=$(( $i + 1 ))
        D="${args[$n]}"
        i=$(( $i + 1 ))
    else
        args_filter[${#args_filter[@]}]="${args[$i]}"
    fi
done

if [[ "$D" == "" ]]; then
    D="0"
fi

if [ $D -eq "0" ];then
    LOG=`date "+%Y%m%d%H"`".log"
elif [ ${#D} -eq 1 ];then
    LOG=`date "+%Y%m%d0"`$D".log"
elif [ ${#D} -eq 2 ]; then
    LOG=`date "+%Y%m%d"`$D".log"
elif [ ${#D} -eq 3 ]; then
    LOG=`date "+%Y%m0"`$D".log"
elif [ ${#D} -eq 4 ]; then
    LOG=`date "+%Y%m"`$D".log"
elif [ ${#D} -eq 5 ]; then
    LOG=`date "+%Y0"`$D".log"
elif [ ${#D} -eq 6 ]; then
    LOG=`date "+%Y"`$D".log"
fi

LOG=$TLOGDIR"*."$LOG
LOG=${LOG//\\/\/}
NLOG=`ls $LOG|wc -l`
if [ $NLOG -eq 0 ]; then
    echo
    echo "file *.$LOG not existed, stop"
    echo
    exit 1
fi

#echo
#echo "exec \"cat $LOG | grep -a ${args_filter[@]}\""
#echo
cat $LOG | grep -a "${args_filter[@]}"|sort -k4