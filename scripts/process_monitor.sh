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

echo
echo "Open Files"
echo "------------------------------------------------------------"

OPEN_FILES=$(ls "/proc/$PID/fd" 2>/dev/null | wc -l)

echo "Open File Descriptors: $OPEN_FILES"

echo
echo "Network / Service Health"
echo "------------------------------------------------------------"

PORT=8080

if ss -ltn | grep -q ":$PORT "; then
    echo "Port $PORT: LISTENING"
else
    echo "Port $PORT: NOT LISTENING"
fi

if curl -s --max-time 3 "http://localhost:$PORT" > /dev/null; then
    echo "HTTP Health: OK"
else
    echo "HTTP Health: FAILED"
fi