#!/usr/bin/env bash

# TODO: add session start time to histfile header
#  https://unix.stackexchange.com/questions/7870/how-to-check-how-long-a-process-has-been-running
#  https://stackoverflow.com/questions/2493642/how-does-a-linux-unix-bash-script-know-its-own-pid/2493661
#  https://superuser.com/questions/150117/how-to-get-parent-pid-of-a-given-process-in-gnu-linux-from-command-line
#  https://askubuntu.com/questions/153976/how-do-i-get-the-parent-process-id-of-a-given-child-process
#  https://topanswers.xyz/nix?q=1547
#echo $BASHPID
#ps -o ppid= -p $BASHPID

echo "######################################" >> "$HISTFILE"
echo "# LOGOUT $(date +%Y%m%dT%H%M%S%z) FOLLOWS" >> "$HISTFILE"
echo "######################################" >> "$HISTFILE"

sh ~/SeeYouSpaceCowboy.sh
sleep 1
