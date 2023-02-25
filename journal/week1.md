# Week 1 — App Containerization

[Omenking-Week1](https://github.com/omenking/aws-bootcamp-cruddur-2023/blob/week-1/journal/week1.md)

in gitpod.
installed docker extension on VS code - it makes it easy to create, manage and debug the containers.

Then created the Dockerfile and pasted the following code.

```
FROM python:3.10-slim-buster

WORKDIR /backend-flask

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

ENV FLASK_ENV=development

EXPOSE ${PORT}
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4567"]
Build Container

```

When we run the above code as a Dockerfile, it will check the requirement.txt (which is in the same directory) and install the flask and flask-cors.

To see what will happen when the container runs the flask and flask-cors I will codes below.

```
#make sure you are in the same directory with the requirement.txt file
pip3 install -r requirements.txt

python3 -m flask run --host=0.0.0.0 --port=4567

```
unlocked the port 4567 under the ports tan in vscode
I was able to run the server but got 404 error


Resolution is:

```
export FRONTEND_URL="*"
export BACKEND_URL="*"
```

- make sure to unlock the port on the port tab
- open the link for 4567 in your browser
- append to the url to /api/activities/home
- you should get back json

### why CMD [] : exec mode?
find out


```
gitpod /workspace/aws-bootcamp-cruddur-2023/backend-flask (week1) $ env | grep BACKEND
BACKEND_URL=*
gitpod /workspace/aws-bootcamp-cruddur-2023/backend-flask (week1) $ unset BACKEND_URL
gitpod /workspace/aws-bootcamp-cruddur-2023/backend-flask (week1) $ env | grep BACKEND

gitpod /workspace/aws-bootcamp-cruddur-2023/backend-flask (week1) $ env | grep FRONTEND
FRONTEND_URL=*
gitpod /workspace/aws-bootcamp-cruddur-2023/backend-flask (week1) $ unset FRONTEND_URL
gitpod /workspace/aws-bootcamp-cruddur-2023/backend-flask (week1) $ env | grep FRONTEND
```

if we name the docker file different than DockerFile, then we have to include the name of the file as -f dockerfile_name in the command below
```

docker build --help
docker container run --help
```
 -f, --file string             Name of the Dockerfile (Default is 'PATH/Dockerfile')\
  -t, --tag list                Name and optionally a tag in the 'name:tag' format\
  ***
  --rm                             Automatically remove the container when it exits\
  -p, --publish list                   Publish a container's port(s) to the host\
  -i, --interactive                    Keep STDIN open even if not attached\
  -t, --tty                            Allocate a pseudo-TTY\
-e, --env list                       Set environment variables\
-d, --detach                         Run container in background and print container ID

```
docker build -t  backend-flask ./backend-flask
#to see the image that is created run
docker image ls
docker run --rm -p 4567:4567 -it backend-flask
```


```
docker run --rm -p 4567:4567 -it -e FRONTEND_URL='*' -e BACKEND_URL='*' backend-flask

```

Get Container Images or Running Container Ids
```
gitpod /workspace/aws-bootcamp-cruddur-2023 (week1) $ docker image ls
REPOSITORY      TAG                IMAGE ID       CREATED          SIZE
backend-flask   latest             c8d3497f7aa9   43 minutes ago   129MB
python          3.10-slim-buster   b5d627f77479   13 days ago      118MB

gitpod /workspace/aws-bootcamp-cruddur-2023 (week1) $ docker container ls
CONTAINER ID   IMAGE           COMMAND                  CREATED          STATUS          PORTS                                       NAMES
8b41ac9b4fda   backend-flask   "python3 -m flask ru…"   27 seconds ago   Up 26 seconds   0.0.0.0:4567->4567/tcp, :::4567->4567/tcp   trusting_carver
gitpod /workspace/aws-bootcamp-cruddur-2023 (week1) $ 
```


## Containerize Frontend
Run NPM Install
We have to run NPM Install before building the container since it needs to copy the contents of node_modules
```
cd frontend-react-js
npm i
```
Create Docker File
Create a file here: frontend-react-js/Dockerfile

FROM node:16.18

ENV PORT=3000

COPY . /frontend-react-js
WORKDIR /frontend-react-js
RUN npm install
EXPOSE ${PORT}
CMD ["npm", "start"]


Build Container
docker build -t frontend-react-js ./frontend-react-js
Run Container
docker run -p 3000:3000 -d frontend-react-js

It worked.

3000
https://3000-abdullahkay-awsbootcamp-cnpztvxv4wo.ws-us87.gitpod.io

Multiple Containers
Create a docker-compose file
Create docker-compose.yml at the root of your project.

version: "3.8"
services:
  backend-flask:
    environment:
      FRONTEND_URL: "https://3000-${GITPOD_WORKSPACE_ID}.${GITPOD_WORKSPACE_CLUSTER_HOST}"
      BACKEND_URL: "https://4567-${GITPOD_WORKSPACE_ID}.${GITPOD_WORKSPACE_CLUSTER_HOST}"
    build: ./backend-flask
    ports:
      - "4567:4567"
    volumes:
      - ./backend-flask:/backend-flask
  frontend-react-js:
    environment:
      REACT_APP_BACKEND_URL: "https://4567-${GITPOD_WORKSPACE_ID}.${GITPOD_WORKSPACE_CLUSTER_HOST}"
    build: ./frontend-react-js
    ports:
      - "3000:3000"
    volumes:
      - ./frontend-react-js:/frontend-react-js

# the name flag is a hack to change the default prepend folder
# name when outputting the image names
networks: 
  internal-network:
    driver: bridge
    name: cruddur

```
docker-compose up
# end of the class
docker-compose down
```






## Homework Challenges    
- Run the dockerfile CMD as an external script
- Push and tag a image to DockerHub (they have a free tier)
- Use multi-stage building for a Dockerfile build
- Implement a healthcheck in the V3 Docker compose file
- Research best practices of Dockerfiles and attempt to implement it in your Dockerfile
- Learn how to install Docker on your localmachine and get the same containers running outside of Gitpod / Codespaces
- Launch an EC2 instance that has docker installed, and pull a container to demonstrate you can run your own docker processes. 


## Todo Checklist
- [Watch How to Ask for Technical Help]	(https://www.youtube.com/watch?v=tDPqmwKMP7Y&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=29)
- [Watched Grading Homework Summaries]	(https://www.youtube.com/watch?v=FKAScachFgk&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=25)
- [Watched Week 1 - Live Streamed Video]	(https://www.youtube.com/watch?v=zJnNe5Nv4tE&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=22)
- [Remember to Commit Your Code]	(https://www.youtube.com/watch?v=b-idMgFFcpg&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=23)
- [Watcked Chirag's Week 1 - Spending Considerations]	(https://www.youtube.com/watch?v=OAMHu1NiYoI&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=24)
- [Watched Ashish's Week 1 - Container Security Considerations]	(https://www.youtube.com/watch?v=OjZz4D0B-cA&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&)index=25
- [Containerize Application (Dockerfiles, Docker Compose)]	(https://www.youtube.com/watch?v=zJnNe5Nv4tE&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&)index=22
- [Document the Notification Endpoint for the OpenAI Document]	(https://www.youtube.com/watch?v=k-_o0cCpksk&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&)index=27
- [Write a Flask Backend Endpoint for Notifications]	(https://www.youtube.com/watch?v=k-_o0cCpksk&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=27)
- [Write a React Page for Notifications]	(https://www.youtube.com/watch?v=k-_o0cCpksk&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=27)
- [Run DynamoDB Local Container and ensure it works]	(https://www.youtube.com/watch?v=CbQNMaa6zTg&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=28)
- [Run Postgres Container and ensure it works]	(https://www.youtube.com/watch?v=CbQNMaa6zTg&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=28)

Create a table
```
aws dynamodb create-table \
    --endpoint-url http://localhost:8000 \
    --table-name Music \
    --attribute-definitions \
        AttributeName=Artist,AttributeType=S \
        AttributeName=SongTitle,AttributeType=S \
    --key-schema AttributeName=Artist,KeyType=HASH AttributeName=SongTitle,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --table-class STANDARD
```
    https://github.com/100DaysOfCloud/challenge-dynamodb-local/blob/main/README.md