#!/bin/bash

# Web page monitoring script with email notifications.
# Dependencies: cURL, sendEmail (telnet is no longer needed in this version).
# Edit the 'settings' sections and you're good to go.

# Settings - Mailserver
SMTP_SERVER="smtp.example.com"			# SMTP server.
SMTP_PORT="587"					# Default: 587 for TLS, 465 for SSL.
TLS="yes"					# Set to 'yes' or 'no'.
USERNAME="sender@example.com"			# Email address for SMTP.
PASSWORD="password"				# Password for SMTP.

# Settings - Web page
NAME="example"					# Filename value, change to something unique when using multiple instances.
URL="http://www.example.com/"			# URL of website to monitor.
GREP_ON="yes"					# If set to 'yes', SEARCH_FOR_WORDS will be active. If set to 'no', the entire page will be compared.
SEARCH_FOR_WORDS="Lorem ipsum dolor sit amet"	# Grep (entire) lines with these words. Receive messages about changes or when the words appear/disappear.

# Settings - Message
TO="recipient@example.com"			# Send alert to this address.
SUBJECT="Web page monitor"			# Subject of the message.
MESSAGE="There has been a change on $URL"	# Message body.

# Settings - Script
INTERVAL="10"					# Interval time in seconds. Eg. if set to '10', the webpage will be checked every 10 seconds.
KEEP_RUNNING="no"				# Keep running after a change is found and an email is sent.



# Script - create new.html with content before script starts to prevent error
if [ "$GREP_ON" == "yes" ]; then
    curl $URL -L | grep "$SEARCH_FOR_WORDS" > ${NAME}_new.html
elif [ "$GREP_ON" == "no" ]; then
    curl $URL -L > ${NAME}_new.html
else
    echo "SEARCH_FOR_WORDS ignored because GREP_ON is not specified correctly."
    curl $URL -L > ${NAME}_new.html
fi


# Script - start checks and mail when change is found
for (( ; ; )); do
    mv ${NAME}_new.html ${NAME}_old.html 2> /dev/null
    if [ "$GREP_ON" == "yes" ]; then
        curl $URL -L | grep "$SEARCH_FOR_WORDS" > ${NAME}_new.html
    elif [ "$GREP_ON" == "no" ]; then
        curl $URL -L > ${NAME}_new.html
    else
        echo "SEARCH_FOR_WORDS ignored because GREP_ON is not specified correctly."
        curl $URL -L > ${NAME}_new.html
    fi
    DIFF_COMPARE="$(diff ${NAME}_new.html ${NAME}_old.html)"
    if [ "0" != "${#DIFF_COMPARE}" ]; then
        sendEmail -f $USERNAME -s $SMTP_SERVER:$SMTP_PORT -xu $USERNAME -xp $PASSWORD -t $TO -o tls=$TLS -u $SUBJECT -m $MESSAGE
        if [ "$KEEP_RUNNING" == "no" ]; then
            exit
        fi
    fi
    sleep $INTERVAL
done
