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
