#Install python im ged tagged as 3.10-slim version from DockerHub
FROM python:3.10-slim-buster 

#Switch the working directory to /backend-flask on the container
WORKDIR /backend-flask

#Copy requirement.txt from here to the container into the backend-flask directory.
#requirement.txt includes the libraries we will install.
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Copy everything outside of the container to inside of the container to the same directory.
# . means everything here to there
COPY . .

#Set the environment variables
ENV FLASK_ENV=development

#Expose the port as assigned the variable port in the CMD line
EXPOSE ${PORT}


CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4567"]