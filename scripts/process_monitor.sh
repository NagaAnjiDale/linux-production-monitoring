#!/bin/bash

APP="myapp.sh"

PID=$(pgrep -f "$APP")

if [ -z "$PID" ]; then
    echo "CRITICAL: $APP is not running"
    exit 1
fi

echo "Application: $APP"
echo "Status: RUNNING"
echo "PID: $PID"
echo

echo "Process Metrics"
echo "------------------------------------------------------------"

ps -p "$PID" -o pid,ppid,%cpu,%mem,vsz,rss,etime,cmd

echo
echo "Thread Information"
echo "------------------------------------------------------------"

THREAD_COUNT=$(ps -p "$PID" -o nlwp=)

echo "Thread Count: $THREAD_COUNT"