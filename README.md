# Benchmarks for bblfsh

_Note:_ According to the benchmarks drivers v2 are slower about two times than v1 (using v1 protocol in both cases).

### how to run

```bash
$ docker-compose pull && docker-compose up
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
    python        small.py    113.037482ms     83.644261ms     51.002653ms         2.739ms         2.377ms
    python       medium.py    1.408386861s    1.369003541s    519.218594ms        78.837ms        59.981ms
    python        large.py    2.225748945s    2.073929824s     762.24393ms        114.07ms        93.727ms
      java      small.java     95.585916ms    134.532064ms    105.850537ms           579ms           410ms
      java     medium.java    775.441605ms    752.145964ms    160.716846ms           660ms           488ms
      java      large.java    1.993296527s    1.777951175s    308.589848ms           889ms           608ms
javascript        small.js     59.031241ms      53.34129ms     42.602787ms             N/A             N/A
javascript       medium.js    798.804496ms    715.325667ms    113.373702ms             N/A             N/A
javascript        large.js    5.455405503s     5.19979398s    441.042201ms             N/A             N/A

$ COUNT=100 ON_HOST=1 bash ./run.sh
Process 100 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host
    python        small.py    1.492257054s     1.30530313s    384.987717ms         52.52ms        48.358ms
    python       medium.py   26.437739908s   27.657225961s    9.932052044s       404.753ms        230.46ms
    python        large.py   45.335606032s    42.49090653s    16.88422919s       156.429ms       873.311ms
      java      small.java    1.196784444s    1.099890111s    482.384224ms           767ms           806ms
      java     medium.java   14.440852591s    15.99131951s    2.057669402s          1458ms          1141ms
      java      large.java   42.868031931s   34.986266717s    3.982363582s          2388ms          1614ms
javascript        small.js    1.144964133s    982.114736ms    185.275143ms             N/A             N/A
javascript       medium.js   14.354297118s   13.033709737s    830.110305ms             N/A             N/A
javascript        large.js  1m53.45431482s 1m42.821524276s    6.280967982s             N/A             N/A
```
