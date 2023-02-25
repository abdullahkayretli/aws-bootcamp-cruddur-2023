FROM mcr.microsoft.com/java/jdk:8-zulu-alpine AS compiler
COPY /source /usr/src/testapp
WORKDIR /usr/src/testapp
RUN javac testapp.java

FROM mcr.microsoft.com/java/jre:8-zulu-alpine
WORKDIR /testapp
COPY --from=compiler /usr/src/testapp .
CMD ["java", "testapp"]