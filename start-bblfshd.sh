bblfshd &
sleep 1
echo "installing drivers"
sleep 1
bblfshctl driver install python docker://bblfsh/python-driver:v2.8.0
bblfshctl driver install java docker://bblfsh/java-driver:v2.6.0
bblfshctl driver install javascript docker://bblfsh/javascript-driver:v2.6.0
echo "all drivers installed"
tail -f /dev/null
