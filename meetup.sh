#!/bin/sh
for topic in $(cat topics.txt | sed -e "s/ /%20/g")
do
  TOPIC=$(echo $topic)
  JSON=$(curl "https://api.meetup.com/find/topics?photo-host=public&page=1&query=$TOPIC&key=$1" 2>/dev/null)
  TOPIC_ID=$(echo $JSON | jq ".[0].id")
  TOPIC_NAME=$(echo $JSON | jq -r ".[0].name")
  #echo "$TOPIC_NAME $TOPIC_ID"
  for location in $(cat locations.txt | sed -e "s/ /%20/g")
  do
    LOCATION=$(echo $location)
    #echo "Getting $TOPIC_NAME Meetups in $LOCATION"
    #echo curl "https://api.meetup.com/find/groups?location=$location&radius=1&topic_id=$TOPIC_ID&order=members&key=$1&page=1"
    MEETUP_URL=$(curl "https://api.meetup.com/find/groups?location=$LOCATION&radius=1&topic_id=$TOPIC_ID&order=members&key=$1&page=1" 2>/dev/null | jq -r ".[0].link")
    if [[ "$MEETUP_URL" != "null" ]]
    then
      MEETUP_NAME=$(curl "https://api.meetup.com/find/groups?location=$LOCATION&radius=1&topic_id=$TOPIC_ID&order=members&key=$1&page=1" 2>/dev/null | jq -r ".[0].name")
      MEETUP_CITY=$(curl "https://api.meetup.com/find/groups?location=$LOCATION&radius=1&topic_id=$TOPIC_ID&order=members&key=$1&page=1" 2>/dev/null | jq -r ".[0].city")
      MEETUP_MEMBERS=$(curl "https://api.meetup.com/find/groups?location=$LOCATION&radius=1&topic_id=$TOPIC_ID&order=members&key=$1&page=1" 2>/dev/null | jq -r ".[0].members")
      echo "$MEETUP_NAME\t$MEETUP_CITY\t$MEETUP_MEMBERS\t$MEETUP_URL\t$topic"
    fi
    exit
  done
done