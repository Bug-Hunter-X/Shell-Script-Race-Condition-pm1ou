#!/bin/bash

# This script demonstrates a solution to the race condition by using a lock file.

counter=0
lock_file="counter.lock"

process1() {
  local i
  for i in {1..1000}; do
    # Acquire the lock
    flock -n "$lock_file" || exit 1
    #Critical Section
    counter=$((counter + 1))
    # Release the lock
    flock -u "$lock_file"
  done
}

process2() {
  local i
  for i in {1..1000}; do
    # Acquire the lock
    flock -n "$lock_file" || exit 1
    #Critical Section
    counter=$((counter + 1))
    # Release the lock
    flock -u "$lock_file"
  done
}

# Create the lock file
: > "$lock_file"

# Start the processes in the background
process1 &
process2 &

# Wait for the processes to finish
wait

# Remove the lock file
rm "$lock_file"

# Print the final counter value. It should now be 2000.

echo "Final counter value: $counter"