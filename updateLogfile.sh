#!/bin/bash

echo "Update przed: $LOGFILE"
LOGFILE="updated_logfile"
export LOGFILE
echo "Update po: $LOGFILE"
