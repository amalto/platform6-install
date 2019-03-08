#!/usr/bin/env bash
docker exec -it p6core tail -f /opt/b2box5.data/logs/b2box.log | awk '
  BEGIN{startingLine=0;color="\033[0m"}
  {matched=0}
  /^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}\:[0-9]{2}\:[0-9]{2}\,[0-9]{3}/ {startingLine=1}

  startingLine==1 && matched == 0 && /DEBUG|TRACE/ {matched=1; color="\033[0;37m"}
  startingLine==1 && matched == 0 && /INFO/ {matched=1; color="\033[0;36m"}
  startingLine==1 && matched == 0 && /WARN/ {matched=1; color="\033[0;33m"}
  startingLine==1 && matched == 0 && /ERROR|FATAL/   {matched=1; color="\033[0;31m"}

  {print color $0 "\033[0m"}
'
