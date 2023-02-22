#Install python im ged tagged as 3.10-slim version from DockerHub
FROM python:3.10-slim-buster 

#Switch the working directory to /backend-flask on the container
WORKDIR /backend-flask

#Copy requirement.txt from here to the container into the backend-flask directory.
#requirement.txt includes the libraries we will install.
COPY requirements.txt requirements.txt

#inside the container, install the python libraries 
RUN pip3 install -r requirements.txt

# Copy everything outside of the container to inside of the container to the same directory.
# . means everything here to there
COPY . .

#Set the environment variables and inside the container it will remain set during the run
ENV FLASK_ENV=development

#Expose the port as assigned the variable port in the CMD line
EXPOSE ${PORT}

#after the container is up it will process the commands below to run the flask
#python3 -m flask run --host=0.0.0.0 --port=4567
#-m represent to run module flask
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=4567"]