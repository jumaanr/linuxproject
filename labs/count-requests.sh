#!/bin/bash
  
echo -e " Log name   \t      GET      \t      POST    \t   DELETE "
echo -e "------------------------------------------------------------"

for appname in $(cat /home/bob/apps.txt)
do
    get_requests=$(cat /var/log/apps/${appname}_app.log | grep "GET" | wc -l)
    post_requests=$(cat /var/log/apps/${appname}_app.log | grep "POST" | wc -l)
    delete_requests=$(cat /var/log/apps/${appname}_app.log | grep "DELETE" | wc -l)

    echo -e " $appname   \t ${get_requests}    \t    ${post_requests}   \t   ${delete_requests}"
done



