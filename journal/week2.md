# Week 2 — Distributed Tracing
[**Week2 Instruction - Click here**](https://github.com/omenking/aws-bootcamp-cruddur-2023/blob/week-2/journal/week2.md)

- [Week 2 — Distributed Tracing](#week-2--distributed-tracing)
  - [Todo Checklist - Observability](#todo-checklist---observability)
  - [Homework Challenges](#homework-challenges)
    - [Instrument Honeycomb with OTEL](#instrument-honeycomb-with-otel)


## Todo Checklist - Observability

- [Watch Week 2 Live-Stream Video](https://youtu.be/2GD9xCzRId4?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Watch Chirag Week 2 - Spending Considerations (Coming Soon)]()
- [Watched Ashish's Week 2 - Observability Security Considerations](https://youtu.be/bOf4ITxAcXc?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Instrument Honeycomb with OTEL](https://youtu.be/2GD9xCzRId4?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Instrument AWS X-Ray](https://youtu.be/n2DTsuBrD_A?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Configure custom logger to send to CloudWatch Logs](https://youtu.be/ipdFizZjOF4?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
- [Integrate Rollbar and capture and error](https://youtu.be/xMBDAb5SEU4?list=PLBfufR7vyJJ7k25byhRXJldB5AiwgNnWv)
  

## Homework Challenges 

- Instrument Honeycomb for the frontend-application to observe network latency between frontend and backend[HARD]
- Add custom instrumentation to Honeycomb to add more attributes eg. UserId, Add a custom span
- Run custom queries in Honeycomb and save them later eg. Latency by UserID, Recent Traces


***
### Instrument Honeycomb with OTEL


You'll need to grab the API key from your honeycomb account:

export HONEYCOMB_API_KEY="SZnpSHqgx20eNChoZHUjrF"
export HONEYCOMB_SERVICE_NAME="Cruddur"
gp env HONEYCOMB_API_KEY="SZnpSHqgx20eNChoZHUjrF"
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
