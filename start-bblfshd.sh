bblfshd &
sleep 1
echo "installing drivers"
sleep 1
bblfshctl driver install python docker://bblfsh/python-driver:v2.10.0
bblfshctl driver install java docker://bblfsh/java-driver:v2.7.2
bblfshctl driver install javascript docker://bblfsh/javascript-driver:v2.9.0
echo "all drivers installed"
tail -f /dev/null
