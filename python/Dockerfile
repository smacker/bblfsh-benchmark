FROM alpine:3.7

RUN apk add --no-cache --update python python3
ADD parse.py /parse.py

CMD ["/bin/sh", "-c", "tail -f /dev/null"]
