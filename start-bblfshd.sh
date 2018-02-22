bblfshd &
sleep 1
echo "installing drivers"
sleep 1
bblfshctl driver install --recommended
tail -f /dev/null
