#!/bin/bash

csv_file="$HOME/TOP.csv"

echo "CPU%,MEM%,COMMAND,Notification" > "$csv_file"

while true;
do
    top_data=$(top -b -n 1 | awk 'NR>7 && ($9 > 5 || $9 > 10) {cpu=$9; mem=$10; command=$12; if (cpu > 10) { notification="Exceeding 10%"; } else { notification="Exceeding 5%"; } print cpu "," mem "," command "," notification }')

    echo -e "$top_data" >> "$csv_file"

    echo -e "Please find the updated data attached." | mail -s "Top Command Data" -A "$csv_file" nanuchavan12@gmail.com

    sleep 30

done

