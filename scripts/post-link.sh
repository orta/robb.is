date=$(date +%F)

title=$( curl -s $1 | awk 'BEGIN{IGNORECASE=1;FS="<title>|</title>";RS=EOF} {print $2}' | tr -d "\n")

filename="$date-$( echo $title | tr "A-Z" "a-z" | tr " " "-" ).md"

post=$(cat <<POST
---
layout:   post
title:    $title
color:    000000
link:     $1
category: ❤ing
---
POST)

echo "$post" > "./_posts/$filename"

subl "./_posts/$filename"
