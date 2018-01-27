FROM alpine:3.6

RUN apk add --no-cache openjdk8-jre=8.131.11-r2
ADD target/native-jar-with-dependencies.jar /native-jar-with-dependencies.jar

CMD ["/bin/sh", "-c", "tail -f /dev/null"]
