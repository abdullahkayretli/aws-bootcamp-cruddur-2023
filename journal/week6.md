# Week 6 & week 7 — Serverless Containers

<table border="1">
  <tr>
    <td>
      <h2>Class Summary</h2>
      <ul>
        <li>Deploy an ECS Cluster using ECS Service Connect</li>
        <li>Deploy serverless containers using Fargate for the Backend and Frontend Application</li>
        <li>Route traffic to the frontend and backend on different subdomains using Application Load Balancer</li>
        <li>Securing our flask container</li>
        <li>Creating several bash utility scripts to easily work with serverless containers.</li>
      </ul>
    </td>
  </tr>
</table>

[Click for Week 6 Instruction](https://github.com/omenking/aws-bootcamp-cruddur-2023/blob/week-6/journal/week6.md)


- [Todo Checklist](#todo-checklist)
- [Required work and Class Instructions](#required-work-and-class-instructions)
- [Homework Challenge](#homework-challenges)

***
# Todo Checklist
- [Watch ECS Security by Ashish](https://www.youtube.com/watch?v=zz2FQAk1I28&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=57)
- [Watch Fargate Technical Questions with Maish (Not yet uploaded)]()
- [Provision ECS Cluster](https://www.youtube.com/watch?v=QIZx2NhdCMI&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=58)
- [Create ECR repo and push image for backend-flask](https://www.youtube.com/watch?v=QIZx2NhdCMI&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=58)
- [Deploy Backend Flask app as a service to Fargate](https://www.youtube.com/watch?v=QIZx2NhdCMI&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=58)
- [Create ECR repo and push image for fronted-react-js](https://www.youtube.com/watch?v=HHmpZ5hqh1I&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=59)
- [Deploy Frontend React JS app as a service to Fargate](https://www.youtube.com/watch?v=HHmpZ5hqh1I&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=59)
- [Provision and configure Application Load Balancer along with target groups](https://www.youtube.com/watch?v=HHmpZ5hqh1I&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=59)
- [Manage your domain useing Route53 via hosted zone](https://www.youtube.com/watch?v=HHmpZ5hqh1I&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=59)
- [Create an SSL cerificate via ACM](https://www.youtube.com/watch?v=HHmpZ5hqh1I&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=59)
- [Setup a record set for naked domain to point to frontend-react-js](https://www.youtube.com/watch?v=HHmpZ5hqh1I&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=59)
- [Setup a record set for api subdomain to point to the backend-flask](https://www.youtube.com/watch?v=HHmpZ5hqh1I&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=59)
- [Configure CORS to only permit traffic from our domain](https://www.youtube.com/watch?v=HHmpZ5hqh1I&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=59)
- [Secure Flask by not running in debug mode](https://www.youtube.com/watch?v=9OQZSBKzIgs&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=60)
- [Implement Refresh Token for Amazon Cognito](https://www.youtube.com/watch?v=LNLP2dxa5EQ&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=63)
- [Refactor bin directory to be top level](https://www.youtube.com/watch?v=HyJOjBjieb4&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=62)
- [Configure task defintions to contain x-ray and turn on Container Insights](https://www.youtube.com/watch?v=G_8_xtS2MsY&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=64)
- [Change Docker Compose to explicitly use a user-defined network](https://www.youtube.com/watch?v=G_8_xtS2MsY&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=64)
- [Create Dockerfile specfically for production use case](https://www.youtube.com/watch?v=G_8_xtS2MsY&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=64)
- [Using ruby generate out env dot files for docker using erb templates](https://www.youtube.com/watch?v=G_8_xtS2MsY&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=64)

***

# Required work and Class Instructions

***

# Homework Challenges