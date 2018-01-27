#!/bin/bash

set -e

go build -o tester *.go

COUNT=${COUNT:-5}
ON_HOST=${ON_HOST:-0}
declare -A ports
ports=(
    ["bblfshd"]="9800"
    ["python-driver"]="9801"
    ["java-driver"]="9802"
)
declare -A naive_commands
naive_commands=(
    ["python"]="python3 /parse.py"
    ["java"]="java -jar /native-jar-with-dependencies.jar"
)
declare -A naive_host_commands
naive_host_commands=(
    ["python"]="python3 python/parse.py"
    ["java"]="java -jar java/target/native-jar-with-dependencies.jar"
)

template="%10s %15s %15s %15s %15s %15s %15s\n"

echo "Process $COUNT times each file"
printf "$template" "language" "fixture" "bblfshd" "driver" "native" "naive" "naive-on-host"
function row() {
    bblfshd=`./tester --language $1 --path fixtures/$2 --times $COUNT --port "${ports[bblfshd]}"`
    driver=`./tester --language $1 --path fixtures/$2 --times $COUNT --port "${ports[$1-driver]}"`
    native=`./tester --language $1 --path fixtures/$2 --times $COUNT --native "bblfshbenchmark_$1-driver_1"`
    naive=`docker exec bblfshbenchmark_$1-naive_1 /bin/sh -c "${naive_commands[$1]} /fixtures/$2 $COUNT"`
    naiveHost="N/A"
    if [[ "$ON_HOST" != "0" ]]; then
        naiveHost=`${naive_host_commands[$1]} fixtures/$2 $COUNT`
    fi
    printf "$template" "$1" "$2" "$bblfshd" "$driver" "$native" "$naive" "$naiveHost"
}

row python small.py
row python medium.py
row python large.py

row java small.java
row java medium.java
row java large.java
