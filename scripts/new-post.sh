date=$(date +%F)

filename="$date-$( echo $1 | tr "A-Z" "a-z" | tr " " "-" ).md"

post=$(cat <<POST
---
layout:   post
title:    $1
color:    000000
category: ❤ing
---
POST)

echo "$post" > "./_posts/$filename"

subl "./_posts/$filename"
