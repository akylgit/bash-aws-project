#!/bin/bash
servers=("www.japantimes.co.jp" "www.akipress.kg" "yandex.ru" "google.com")
for server in "${servers[@]}"; do
ping -c 5 $server
if [ $? -eq 0 ]; then
echo "Ping to $server successful." >> ping_results.log
else
echo "Ping to $server failed." >> ping_results.log
fi
done
