#!/bin/bash

# Add colour to you log output with this script.  Run from your deployment folder as:  ../../scripts/p6logs.sh

. .env

tail -f -n 1000 $PLATFORM6_DATA_PATH/$INSTANCE_ID/p6core.data/logs/p6core.log | awk '
  BEGIN{startingLine=0;color="\033[0m"}
  {matched=0}
  /^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}\:[0-9]{2}\:[0-9]{2}\,[0-9]{3}/ {startingLine=1}
  startingLine==1 && matched == 0 && /DEBUG|TRACE/ {matched=1; color="\033[0;37m"}
  startingLine==1 && matched == 0 && /INFO/ {matched=1; color="\033[0;36m"}
  startingLine==1 && matched == 0 && /WARN/ {matched=1; color="\033[0;33m"}
  startingLine==1 && matched == 0 && /ERROR|FATAL/   {matched=1; color="\033[0;31m"}
  {print color $0 "\033[0m"}
'