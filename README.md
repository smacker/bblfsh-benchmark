# Benchmarks for bblfsh

_Note:_ According to the benchmarks drivers v2 are slower about two times than v1.

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
    python        small.py    104.513341ms     70.359426ms     84.412696ms         3.603ms          3.06ms
    python       medium.py    1.434026919s    1.361810796s    621.382857ms        82.287ms        56.231ms
    python        large.py    2.238042851s    2.328555477s    921.827309ms       136.489ms        90.404ms
      java      small.java    156.962567ms    115.947404ms    149.711802ms           761ms           531ms
      java     medium.java    724.721846ms    868.051587ms    327.612868ms           929ms           482ms
      java      large.java    1.624739807s    1.592108453s    548.594095ms          1059ms           605ms
javascript        small.js     158.19833ms    152.655977ms     87.472874ms             N/A             N/A
javascript       medium.js    908.064627ms     923.07357ms    251.559531ms             N/A             N/A
javascript        large.js    7.364783215s    6.453128516s    626.814047ms             N/A             N/A


$ COUNT=100 ON_HOST=1 bash ./run.sh
Process 100 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host
    python        small.py     1.96979725s    1.798308185s    603.633402ms        69.124ms        46.292ms
    python       medium.py   28.846915992s   27.890701959s   11.347615686s       571.396ms        46.084ms
    python        large.py   45.007683765s   45.632372333s   17.624723382s       734.178ms       780.307ms
      java      small.java     1.74572002s    1.489998826s    651.211843ms          1148ms           763ms
      java     medium.java   11.703973963s   11.462978285s    2.073788281s          1587ms          1040ms
      java      large.java   30.309241377s   30.144050923s    3.774792657s          2469ms          1649ms
javascript        small.js    1.512326812s    1.239894324s    204.323864ms             N/A             N/A
javascript       medium.js   16.420600669s   15.755297156s     1.10123314s             N/A             N/A
javascript        large.js  2m3.068879896s  2m3.564357892s     5.70595184s             N/A             N/A
```
