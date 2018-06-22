bblfshd &
sleep 1
echo "installing drivers"
sleep 1
bblfshctl driver install --recommended
echo "all drivers installed"
tail -f /dev/null
