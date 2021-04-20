#!/bin/bash

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
NC='\033[0m' # No Color

messages=()
addresses=()
subject=$3

{
  read;
  while IFS=, read -r NAME TO EMAIL_ADDRESS;
  do
    if [[ -n "$EMAIL_ADDRESS" ]]; then
      m=$(<$2)
      message=${m/_TO_/$TO}
      messages+=("${message}")
      addresses+=("${EMAIL_ADDRESS}")
    fi
  done;
} < $1

clear
echo "First message
----------------"

for i in "${!messages[@]}"
do
  printf "${Cyan}To: $White${addresses[$i]}$NC\n\n"
  printf "$Cyan${messages[$i]}\n\n$White------------$NC\n\n"
done

# Check if we should continue
echo "Is it Ok (y/n)?"
read continue
if [ $continue != "y" ]; then
  echo "Exited"
  exit
fi

printf "${Red}We will send that email to the following receipients. Please check them:$Nc\n"
echo ""

# Print addresses to check
for addr in "${addresses[@]}"
do
  printf "$Yellow$addr$NC\n"
done

# Check if we should continue
printf "\n\nShould continue? (y/n)\n"
read continue
if [ $continue != "y" ]; then
  echo "Exited"
  exit
fi

# Last check before send
printf "Can we send all the ${#addresses[@]} emails? (y/n)"
read continue
if [ $continue != "y" ]; then
  echo "Exited"
  exit
fi

# Send emails
for i in "${!messages[@]}"
do
  echo Sending email to ${addresses[$i]}
  echo "${messages[$i]}" | mailx \
      -r "mezeipetister@gmail.com" \
      -s "${subject}" \
      -S smtp="smtp.gmail.com:587" \
      -S smtp-use-starttls \
      -S smtp-auth=login \
      -S smtp-auth-user="mezeipetister@gmail.com" \
      -S smtp-auth-password="szyfgvcbxyngrpdt" \
      -S ssl-verify=ignore   ${addresses[$i]}
done
