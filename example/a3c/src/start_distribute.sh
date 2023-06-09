#!/bin/bash
# Launch 1 scheduler.
if [ $2 == scheduler ];then
    export MS_WORKER_NUM=$3
    export MS_SCHED_HOST=$4
    export MS_SCHED_PORT=$5
    export MS_ROLE=MS_SCHED
    python $1 > scheduler.txt 2>&1 &
    sched_pid=${!}
    echo "Scheduler $sched_pid start success!"
    exit 0
fi

# Launch workers
if [ $2 == worker ];then
    export MS_WORKER_NUM=$3
    export MS_SCHED_HOST=$5
    export MS_SCHED_PORT=$6
    export MS_ROLE=MS_WORKER
    for((i=0;i<$4;i++));
    do
        python $1 > worker_$i.txt 2>&1 &
        echo "Worker ${i} start success with pid ${!}"
    done
    exit 0
fi

echo "Failed!"
exit 1