#!/bin/bash

# Check if a parameter is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <minutes>"
    exit 1
fi

# Validate that the parameter is a positive number
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: Please provide a valid number of minutes."
    exit 1
fi

# Set Pomodoro duration (convert minutes to seconds)
POMODORO=$(( $1 * 60 ))
# Set break duration to 1/5 of Pomodoro time, minimum 1 minute
BREAK=$(( POMODORO / 5 ))
[ $BREAK -lt 60 ] && BREAK=60

echo "Starting $1-minute Pomodoro timer..."

# Wait for Pomodoro duration
sleep $POMODORO

# Notify when done
if command -v notify-send >/dev/null 2>&1; then
    notify-send "Pomodoro Timer" "$1 minutes are up! Time for a $(( BREAK / 60 ))-minute break."
else
    echo "Pomodoro done! Time for a $(( BREAK / 60 ))-minute break."
fi

# Wait for break duration
sleep $BREAK

# Notify when break is over
if command -v notify-send >/dev/null 2>&1; then
    notify-send "Pomodoro Timer" "Break is over! Start the next Pomodoro."
else
    echo "Break is over! Start the next Pomodoro."
fi
