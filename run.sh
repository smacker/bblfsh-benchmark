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
    ["javascript-driver"]="9803"
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

template="%10s %15s %15s %15s %15s %15s %15s %15s\n"

echo "Process $COUNT times each file"
printf "$template" "language" "fixture" "bblfshd" "driver" "native" "naive" "naive-on-host" "go-tree-sitter"
function row() {
    bblfshd=`./tester --language $1 --path fixtures/$2 --times $COUNT --port "${ports[bblfshd]}"`
    driver=`./tester --language $1 --path fixtures/$2 --times $COUNT --port "${ports[$1-driver]}"`
    native=`./tester --language $1 --path fixtures/$2 --times $COUNT --native "bblfsh-benchmark_$1-driver_1"`
    naive="N/A"
    if [[ "${naive_commands[$1]}" != "" ]]; then
        naive=`docker exec bblfsh-benchmark_$1-naive_1 /bin/sh -c "${naive_commands[$1]} /fixtures/$2 $COUNT"`
    fi
    naiveHost="N/A"
    if [[ "$ON_HOST" != "0" && "${naive_commands[$1]}" != "" ]]; then
        naiveHost=`${naive_host_commands[$1]} fixtures/$2 $COUNT`
    fi
    treeSitter=`./tester --language $1 --path fixtures/$2 --times $COUNT --tree-sitter`
    printf "$template" "$1" "$2" "$bblfshd" "$driver" "$native" "$naive" "$naiveHost" "$treeSitter"
}

row python small.py
row python medium.py
row python large.py

row java small.java
row java medium.java
row java large.java

row javascript small.js
row javascript medium.js
row javascript large.js
