# Week 0 — Billing and Architecture

## Reqired Homework/ Tasks:
***
### Create an Admin User
I watched the video for [**Ashish's Week 0 - Security Considerations**](https://www.youtube.com/watch?v=4EMWBYVggQI&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=15:target="_blank").\
I already created an AWS root account. It is not recommended to work on your AWS root account, so;\
I jumped into the **IAM** dashboard and created a **User group** named as "ADMIN".\
I gave **AdministratosAccess** permisions to this group.
Finaly, I created a new user, and added to the Admin group.
***
### Create a Billing Alarm via AWS Console
I watched the video for [**Chirag's Week 0 - Spend Considerations**](https://www.youtube.com/watch?v=OVw3RrlP-sI&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=13) and set my billing alarm with $5 max. Here is the screenshot of the alarm  I created.
![Alt text](../_docs/assets/Billing%20Alarm.jpg)
I added the step by step instruction for this at the end of the page under the [**Instructions**](#steps-to-create-a-billing-alarm-on-aws)

### Create a Billing Alarm via AWS CLI
First I created an SNS topic and got the topic-arn. Here is the code:

```
aws sns create-topic --name billing-alarm
```
Then I created a subscription. Used the code below,

```
aws sns subscribe \
    --topic-arn ***your topic-arn, that you got in the step above***\
    --protocol email \
    --notification-endpoint ***the email you want to subscribe***
```

Finally I created theAlarm with the JSON file listed below, that I created before. Ran the CLI code below. 
- [alarm-config.json](../aws/json/alarm-config.json)\
More information about the JSON file click
[ here](https://aws.amazon.com/premiumsupport/knowledge-center/cloudwatch-estimatedcharges-alarm/).\

Run the CLI code below.
```
aws cloudwatch put-metric-alarm --cli-input-json file://aws/json/alarm-config.json
```

***
### Create a Budget via AWS Console
After watched the video above, I set my budget to $10 per month. Here is the screenshot for the budget at AWS.
![Alt text](../_docs/assets/AWS%20Budget.jpg)
Step by step [**instruction**](#steps-to-set-up-a-budget-on-aws) via AWS console is below as well. 

### Create a budget via AWS CLI
After I created the json files listed below, I typed the folllowing code to create a budget with $10 and 80% treshold.
- [budget.json](../aws/json/budget.json)
- [budget-notifications-with-subscribers.json](../aws/json/budget-notifications-with-subscribers.json)\
  More information about the JSON files click [here](https://docs.aws.amazon.com/cli/latest/reference/budgets/create-budget.html#examples).
```
aws budgets create-budget \
    --account-id **your-AWS-account-id** \
    --budget file://aws/json/budget.json \
    --notifications-with-subscribers file://aws/json/budget-notifications-with-subscribers.json
```

***
### Installed AWS CLI and Generate AWS Credentials
On my local device I already installed AWS CLI that I was using before. Here is the proof for it.
![Alt text](../_docs/assets/AWS%20CLI%20local.jpg)
<p>As it stands in the business scenario that fractional CTO has asked that everything be developed in Gitpod,so I set my Gitpod account aswell.
</p>

I have realized that I did not have MFA on my GitHub, first I set it up. Step by step [**instruction**](#steps-to-enable-multi-factor-authentication-on-github) is below.
<p>Then I created a workspace at Gitpod with my GitHub repository. 
</p>

I installed the AWS to the /workspace directory and configured with the code below. [**Installing AWS CLI**](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
  
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
cd .. 
unzip awscliv2.zip
sudo ./aws/install
aws configure
```
After the installation I checked it;
```
aws --version
aws
aws sts get-caller-identity
```
![Alt text](../_docs/assets/AWS%20CLI%20at%20Gitpod.jpg)
<p>Before the configuration, I switched to my AWS account and created new Access Key and Secret just for Gitpod. In case in the future if I want to destroy the access key, it will be much easier.</p>
<p>Lastly, for the future log-ins, to set as desired I have updated the [gitpod.yaml](../.gitpod.yml). Which will install the AWS CLI to the desired location.
</p>
<p>Finally, I needed to set env variables for Acces Key, Secret and Region at gitpod settings. 
</p>

[**Env vars for AWS**](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

```
export AWS_ACCESS_KEY_ID=******use your access key********
export AWS_SECRET_ACCESS_KEY=******use your secret********
export AWS_DEFAULT_REGION=******your default region********
``` 
***
## Crudder Projects Architectual Diagrams
<p>A conceptual diagram and a logical diagram are both types of diagrams used in various fields to represent ideas, systems, and processes. However,their purposes and level of details are different.
</p>
<p>A conceptual diagram is a high-level representation of a system or process that provides an overview of its key concepts, relationships, and components. It is usually created in the early stages of a project.
</p>
Here is the conceptional diagram on the napkin.

![Alt text](../_docs/assets/Crudder%20-%20Conceptual%20Diagram.jpeg)

<p>A logical diagram is a more detailed representation of a system or process that describes its logical components, functions, and relationships. It is typically created after the conceptual diagram and provides a more detailed view of the system.</p>
And here is the more detailed representation of a system a logical diagram.

[Click here to see the diagram at LucidCharts](https://lucid.app/lucidchart/invitations/accept/inv_8563f314-f9a4-4928-b8b2-9e241f693f94)	  
	
![Alt text](../_docs/assets/Crudder%20Logical%20Diagram.jpeg)

***
[AWS CLI reference-Budget](https://docs.aws.amazon.com/cli/latest/reference/budgets/create-budget.html#examples)

## Well-Architechted Framework
A well-architected framework is a set of best practices and guidelines that can be used to design and operate reliable, secure, efficient, and cost-effective systems in the cloud. The framework provides a structured approach for architects, developers, and operators to evaluate architectures and design patterns, identify potential issues, and make informed decisions about how to design, deploy, and operate workloads in the cloud.

### Five Pillars of Well-Architechted Framework
1. **Operational Excellence:** This pillar focuses on how to run and manage systems to deliver business value.

2. **Security:** This pillar focuses on protecting information and systems from potential threats.

3. **Reliability:** This pillar focuses on ensuring systems can operate continuously and recover from failures.

4. **Performance Efficiency:** This pillar focuses on optimizing the use of computing resources to meet performance requirements and minimize costs.

5. **Cost Optimization:** This pillar focuses on how to achieve the best balance between cost and performance by taking advantage of cost-effective solutions.

# Instructions

## Steps to Create a Billing Alarm on AWS 

1. Sign in to your AWS account.
2. Go to the **CloudWatch** dashboard.
3. Click on "**All alarms**" in the left-hand menu.
4. Click the "**Create alarm"** button.
5. Choose the metric you want to use for the alarm. In this case, you would select the "**Total Estimated Charge**" metric.
6. Define the threshold for the alarm. This is the amount at which you want to be alerted when your charges exceed.
7. Choose the actions you want to take when the threshold is breached. You can choose to send a notification, stop an instance, or perform other actions.
8. Add a name and description for the alarm.
9. Review the alarm details and click the "**Create alarm**" button.

<p>After you've completed these steps, your billing alarm will be created, and you will be notified when your charges exceed the threshold you set. You can also view and manage your billing alarms on the CloudWatch dashboard at any time.
</p>

***

## Steps to Set up a Budget on AWS

1. Sign in to your AWS account.
2. Go to the **Billing** dashboard.
3. Click on "**Budgets**" in the left-hand menu.
4. Click the "**Create budget**" button.
5. Choose the type of budget you want to create. AWS offers several types of budgets, including cost, usage, and reservation.
6. Fill in the budget details, such as the name, amount, and time period for the budget.
7. Choose the notifications you want to receive when your budget thresholds are met or exceeded. You can choose to receive notifications by email, SNS topic, or both.
8. Review the budget details and click the "**Create**" button.

<p>After you've completed these steps, your budget will be created, and you will receive notifications when your budget thresholds are met or exceeded. You can also view your budget on the Budgets dashboard and make changes to it at any time.
</p>

***

## Steps to Enable Multi-Factor Authentication on GitHub

1. Sign in to your GitHub account.
2. Click on your profile picture in the top right corner of the screen and select "**Settings**" from the dropdown menu.
3. In the left-hand menu, click on "**Password and authentication**".
4. Scroll down and click on the "**Two-factor authentication**" button.
5. Click the "**Set up two-factor authentication**" button.
6. Choose the type of authentication you want to use. GitHub supports several methods, including text message (SMS), authenticator app, or a hardware security key.
7. Follow the instructions for the chosen method to set up your authentication.
***
