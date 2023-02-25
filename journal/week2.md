# Week 2 — Distributed Tracing

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
