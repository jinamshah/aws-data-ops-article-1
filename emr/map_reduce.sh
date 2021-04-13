export PYTHONPATH=$PYTHONPATH:/home/hadoop/Dyson/

ENVIRONMENT='prod'

cd /home/hadoop/blog_code/emr/

spark-submit --master yarn --deploy-mode client map_reduce.py
