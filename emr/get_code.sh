#!/bin/bash
#cd /home/hadoop/
sudo -u root bash -c 'chown -R hadoop /home/hadoop/'

mkdir -p /home/hadoop/blog_code/
cd /home/hadoop/blog_code/ && git init

git pull https://jinamshah/blog.git;
git checkout master

#export PYTHONPATH=$PYTHONPATH:/home/hadoop/blog_code/