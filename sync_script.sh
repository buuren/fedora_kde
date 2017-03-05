#!/bin/bash
GIT_DIR=`pwd`

cd $HOME
ls -d -1 .config/* | grep -v "google-chrome\|sublime-text-3" | xargs -I % cp -r % $GIT_DIR/.config

ls -d 
