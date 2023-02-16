## Create a budget with max $10, treshold 80%
```
aws budgets create-budget \
    --account-id 148806692575 \
    --budget file://aws/json/budget.json \
    --notifications-with-subscribers file://aws/json/budget-notifications-with-subscribers.json
```
## SNS Topic
```
aws sns create-topic --name billing-alarm
```

## Create a subscription supply the TopicARN and our Email
```
aws sns subscribe \
    --topic-arn arn:aws:sns:us-east-1:148806692575:billing-alarm\
    --protocol email \
    --notification-endpoint abdullahkayretli@gmail.com
```

aws cloudwatch put-metric-alarm --cli-input-json file://aws/json/alarm_config.json