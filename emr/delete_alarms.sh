IS_MASTERNODE=false
jobflowid=$(cat /mnt/var/lib/info/job-flow.json | jq -r ".jobFlowId")

if grep isMaster /mnt/var/lib/info/instance.json | grep true;
then
    IS_MASTERNODE=true
fi

if [ "$IS_MASTERNODE" = true ]
then
aws cloudwatch delete-alarms --alarm-names emr-isidle-$jobflowid emr-appsfailed-$jobflowid
fi