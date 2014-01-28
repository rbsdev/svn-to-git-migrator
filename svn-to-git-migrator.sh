#!/bin/bash

PROJECT_HOSTING=$1
PROJECT_OWNER=$2
PROJECT_NAME=$3

if [ "$PROJECT_OWNER" == "" ] || [ "$PROJECT_NAME" == "" ]; then
        echo "Usage: $0 [project_hosting] [project_owner] [project_name]"
        echo "Example: $0 \"github.com\" \"helmedeiros\" \"svn-to-git-migrator\""
        exit 1
fi

url="https://$PROJECT_HOSTING"
echo "Ok, starting migrating the project $PROJECT_NAME by $PROJECT_OWNER from $url"

echo "OK, give me your SVN user."
read USER

if [ "$USER" == "" ]; then
        echo -e "\e[31mIm sorry, but I will need a user."
        echo -e "\e[39m"
        exit;
fi

echo "Transforming from SVN $url/$PROJECT_OWNER/$PROJECT_NAME project to GIT"

echo "Getting from SVN $url/$PROJECT_OWNER/$PROJECT_NAME"
git svn clone --username $USER $url/$PROJECT_OWNER/ $PROJECT_NAME

echo "Do you want to create an shared repository from $PROJECT_NAME ?"
read REMOTE_GIT_REPO

if [ "$REMOTE_GIT_REPO" == "" ] || [ "$REMOTE_GIT_REPO" == "NO" ]; then
        echo -e "\e[31mOk that's your choice."
        echo -e "\e[39m"
        exit;
fi

echo "Creating the new shared repository $PROJECT_NAME.git"
git clone --bare --shared $PROJECT_NAME