#!/bin/bash

NAME=$1
LASTNAME=$2
SHOW=$3

if [ "$SHOW" = "true" ]; then
  echo "Hello, $NAME $LASTNAME"
else
  echo "If you want to see the name, please mark the show option"
fi
[jenkins@localhost jenkins-data]$ cat aws-s3.sh
#/bin/bash

DATE=$(date +%H-%M-%S)
BACKUP=db-$DATE.sql

DB_HOST=$1
DB_PASSWORD=$2
DB_NAME=$3
AWS_SECRET=$4
BUCKET_NAME=$5

mysqldump -u root -h $DB_HOST -p$DB_PASSWORD $DB_NAME > /tmp/$BACKUP && \
export AWS_ACCESS_KEY_ID=AKIA4YPQHSLTYVIZC27X && \
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET && \
echo "Uploading your $BACKUP backup" && \
aws s3 cp /tmp/db-$DATE.sql s3://$BUCKET_NAME/$BACKUP
