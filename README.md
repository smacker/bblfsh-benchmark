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
    python        small.py    146.079827ms    153.370348ms     123.84126ms         5.229ms         2.535ms
    python       medium.py    1.884784564s    1.851744507s    732.822872ms        90.783ms        57.036ms
    python        large.py    2.941428775s    2.796062423s    1.139355155s       149.375ms        91.566ms
      java      small.java    158.033162ms    206.345974ms    140.374503ms           900ms           440ms
      java     medium.java    1.065187547s    1.048998357s    289.455115ms          1061ms           498ms
      java      large.java    2.684512975s    2.451085627s    653.128717ms          1314ms           791ms
javascript        small.js    123.652276ms    122.926993ms      96.85759ms             N/A             N/A
javascript       medium.js    1.175410675s    1.092604058s    218.365734ms             N/A             N/A
javascript        large.js    8.230077793s    7.848468578s    575.058581ms             N/A             N/A


$ COUNT=100 ON_HOST=1 bash ./run.sh
Process 100 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host
    python        small.py    2.168941823s    2.070551953s    538.993958ms        71.067ms        42.555ms
    python       medium.py   36.398426128s   36.533223986s    13.67621504s       223.038ms        207.06ms
    python        large.py  1m4.770520079s  1m12.90423101s   21.920128612s       333.418ms       219.172ms
      java      small.java    2.577226289s    2.273233389s    912.067069ms          1393ms           759ms
      java     medium.java   29.305501304s   19.081959498s    2.850263523s          2202ms          1359ms
      java      large.java   58.275762845s  1m0.810885994s     5.07923743s          3290ms          1854ms
javascript        small.js    8.187768584s     2.00324405s    264.722802ms             N/A             N/A
javascript       medium.js   25.356279203s   21.711730924s    1.138548762s             N/A             N/A
javascript        large.js 2m56.832255898s 2m48.965546815s   11.942310985s             N/A             N/A
```
