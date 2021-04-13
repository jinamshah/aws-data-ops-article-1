IS_MASTERNODE=false
jobflowid=$(cat /mnt/var/lib/info/job-flow.json | jq -r ".jobFlowId")

if grep isMaster /mnt/var/lib/info/instance.json | grep true;
then
    IS_MASTERNODE=true
fi

if [ "$IS_MASTERNODE" = true ]
then
aws cloudwatch put-metric-alarm --alarm-name emr-isidle-$jobflowid --metric-name IsIdle --namespace AWS/ElasticMapReduce --statistic Maximum --comparison-operator GreaterThanOrEqualToThreshold --threshold 1 --dimensions Name="JobFlowId",Value=$jobflowid --evaluation-periods 2 --alarm-actions <INSERT-ARN-FOR-SNS-TOPIC> --period 300
aws cloudwatch put-metric-alarm --alarm-name emr-appsfailed-$jobflowid --metric-name AppsFailed --namespace AWS/ElasticMapReduce --statistic Maximum --comparison-operator GreaterThanOrEqualToThreshold --threshold 1 --dimensions Name="JobFlowId",Value=$jobflowid --evaluation-periods 1 --alarm-actions <INSERT-ARN-FOR-SNS-TOPIC> --period 300
fi