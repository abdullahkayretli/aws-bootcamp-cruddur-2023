# Week 2 — Distributed Tracing
[Click for Week2 Instruction](https://github.com/omenking/aws-bootcamp-cruddur-2023/blob/week-2/journal/week2.md)

- [Checklist](#todo-checklist)
- [Required work and Class Instructions](#required-work-and-class-instructions)
- [Homework Challenge](#homework-challenges)


## Todo Checklist - Observability
- 	https://www.youtube.com/watch?v=2GD9xCzRId4&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=30
	Watch Chirag Week 2 - Spending Considerations (Coming Soon)	
		https://www.youtube.com/watch?v=bOf4ITxAcXc&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=31
		https://www.youtube.com/watch?v=2GD9xCzRId4&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=30
		https://www.youtube.com/watch?v=n2DTsuBrD_A&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=32
	Configure custom logger to send to CloudWatch Logs	https://www.youtube.com/watch?v=ipdFizZjOF4&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=33
	Integrate Rollbar and capture and error	https://www.youtube.com/watch?v=xMBDAb5SEU4&list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv&index=35

- [Watch Week 2 Live-Stream Video](https://youtu.be/2GD9xCzRId4?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Watch Chirag Week 2 - Spending Considerations (Coming Soon)]()
- [Watched Ashish's Week 2 - Observability Security Considerations](https://youtu.be/bOf4ITxAcXc?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Instrument Honeycomb with OTEL](https://youtu.be/2GD9xCzRId4?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Instrument AWS X-Ray](https://youtu.be/n2DTsuBrD_A?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Configure custom logger to send to CloudWatch Logs](https://youtu.be/ipdFizZjOF4?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Integrate Rollbar and capture and error](https://youtu.be/xMBDAb5SEU4?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
  


***
You'll need to grab the API key from your honeycomb account:

export HONEYCOMB_API_KEY=""
export HONEYCOMB_SERVICE_NAME="Cruddur"
gp env HONEYCOMB_API_KEY=""
gp env HONEYCOMB_SERVICE_NAME="Cruddur"


added to the docker compose under environment

Add teh following Env Vars to backend-flask in docker compose

OTEL_EXPORTER_OTLP_ENDPOINT: "https://api.honeycomb.io"
OTEL_EXPORTER_OTLP_HEADERS: "x-honeycomb-team=${HONEYCOMB_API_KEY}"
OTEL_SERVICE_NAME: "${HONEYCOMB_SERVICE_NAME}"


Requirement is updated 

opentelemetry-api
opentelemetry-sdk \
opentelemetry-exporter-otlp-proto-http \
opentelemetry-instrumentation-flask \
opentelemetry-instrumentation-requests

....

npi install to the frontend
docker-compose up
