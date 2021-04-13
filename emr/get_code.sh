#!/bin/bash

sudo -u root bash -c 'chown -R hadoop /home/hadoop/'

mkdir -p /home/hadoop/blog_code/
cd /home/hadoop/blog_code/ && git init

git pull https://jinamshah/aws-data-ops-article-1.git;
git checkout master

# we can also add python requirements here. for example:
# python3 -m pip install pyspark