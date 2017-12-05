#!/bin/ash
set -x

if [ -z "${CORES}" ]; then
export CORES=`grep -c processor /proc/cpuinfo`
fi

export AUTO_CONFIGURATION=$(/app/xmr-stak | grep "low_power_mode")

envtpl /app/xmr-stak.conf.tpl -o /app/xmr-stak.conf --allow-missing --keep-template

if [ "$1" = 'xmr-stak' ]; then
    exec /app/xmr-stak /app/xmr-stak.conf
fi

exec "$@"
