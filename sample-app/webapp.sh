#!/bin/bash

PORT=8080

echo "Starting sample web application on port $PORT"

python3 -m http.server "$PORT"
