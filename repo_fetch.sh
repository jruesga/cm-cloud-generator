#!/bin/bash

GIT_CMD=/usr/bin/git

OLD_PWD=`pwd`
REPO_DIR=$OLD_PWD/db/repos/$1
STATS_DIR=$OLD_PWD/db/stats/$1

echo "REPO: $REPO_DIR"
if [ ! -d "$REPO_DIR" ]; then
    mkdir -p $REPO_DIR
    cd $REPO_DIR
    $GIT_CMD init
    $GIT_CMD remote add origin https://github.com/$1.git
    $GIT_CMD fetch
else
    cd $REPO_DIR
    $GIT_CMD fetch
fi

# Get repository stats
mkdir -p $STATS_DIR
$GIT_CMD shortlog -e -s -n --all > $STATS_DIR/all_stats.dat
$GIT_CMD shortlog -e -s -n --all --grep='Automatic translation import' > $STATS_DIR/translations_stats.dat

cd $OLD_PWD
