# Benchmarks for bblfsh

### how to run

```bash
$ docker-compose up
$ ./run.sh
```

Set environment variables to control `run.sh`:

* `COUNT` - how many times run process file
* `ON_HOST` - run naive parser on host machine

Columns:

* `bblfshd` - grpc calls to bblfsh server using client-go
* `driver` - grpc calls to bblfsh driver using client-go (speaks the same protocol)
* `native` - writes file multiple times to stdin of native driver
* `naive` - the simplest ast parser I came up with, run on docker
* `naive-on-host` - same as previous one but without docker

### Results on my machine:

```
$ ON_HOST=1 bash ./run.sh
Process 5 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host
    python        small.py     56.741761ms     43.109003ms     46.919337ms         2.815ms         2.808ms
    python       medium.py     842.48126ms    800.104448ms    460.084112ms        70.754ms        55.318ms
    python        large.py    1.436457877s    1.392802752s    761.553782ms       114.116ms        98.076ms
      java      small.java     46.870115ms     30.450545ms     63.084239ms           553ms           399ms
      java     medium.java    336.276353ms    310.757303ms    197.141397ms           678ms           475ms
      java      large.java    905.540695ms    830.926882ms    378.289634ms           827ms           620ms

$ COUNT=100 ON_HOST=1 bash ./run.sh
Process 100 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host
    python        small.py    1.019839101s    959.819475ms    403.639806ms        60.176ms        45.874ms
    python       medium.py   18.299109026s   17.611896166s    8.670838679s       428.909ms       114.229ms
    python        large.py   28.221796248s   26.348178298s   13.894410682s       184.779ms       943.968ms
      java      small.java    762.522548ms    610.571072ms    474.168305ms           829ms           611ms
      java     medium.java    6.345935358s    5.524509815s    1.400566447s          1323ms          1078ms
      java      large.java   17.147798252s   15.514799861s    2.985042307s          2050ms          1555ms
```
