bblfshd &
sleep 1
echo "installing drivers"
sleep 1
bblfshctl driver install --all
tail -f /dev/null
