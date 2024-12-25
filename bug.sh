#!/bin/bash

# This script demonstrates a race condition in shell scripting.
# It uses two processes that try to update a counter simultaneously.

counter=0

process1() {
  local i
  for i in {1..1000}; do
    #Critical Section, Race Condition here
    counter=$((counter + 1))
  done
}

process2() {
  local i
  for i in {1..1000}; do
    #Critical Section, Race Condition here
    counter=$((counter + 1))
  done
}

# Start the processes in the background
process1 &
process2 &

# Wait for the processes to finish
wait

# Print the final counter value.  It will likely be less than 2000 due to the race condition.

echo "Final counter value: $counter"