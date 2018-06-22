FROM alpine:3.7

RUN apk add --no-cache openjdk8-jre
ADD target/native-jar-with-dependencies.jar /native-jar-with-dependencies.jar

CMD ["/bin/sh", "-c", "tail -f /dev/null"]
