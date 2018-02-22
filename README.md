# Benchmarks for bblfsh

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
    python        small.py     51.743598ms     43.225469ms     56.703523ms         2.691ms         2.352ms
    python       medium.py    806.355035ms    803.425679ms    441.251012ms        67.363ms        54.213ms
    python        large.py    1.398134455s    1.282806754s    752.523999ms       113.148ms          96.4ms
      java      small.java     39.815334ms     39.289481ms     65.450402ms           391ms           396ms
      java     medium.java    334.004609ms    357.028112ms    159.962666ms           454ms           492ms
      java      large.java    991.674238ms    877.198939ms    248.035139ms           594ms           722ms
javascript        small.js     50.564519ms     32.120037ms     49.057117ms             N/A             N/A
javascript       medium.js    417.411635ms    361.938494ms    158.403883ms             N/A             N/A
javascript        large.js    3.402788377s     3.34308053s    494.037411ms             N/A             N/A

$ COUNT=100 ON_HOST=1 bash ./run.sh
Process 100 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host
    python        small.py    929.210453ms     815.99546ms    363.143593ms        51.176ms        41.474ms
    python       medium.py   16.303130809s   15.879994577s    8.145181101s       313.333ms       133.751ms
    python        large.py   27.653217612s   26.438660983s    13.64112638s       191.035ms       915.243ms
      java      small.java    740.419561ms    674.744789ms    487.885381ms           619ms           604ms
      java     medium.java    6.289137615s    6.015788445s    1.339974701s          1192ms          1073ms
      java      large.java   17.755939238s   15.690162174s    2.844574127s          1844ms          1635ms
javascript        small.js    732.852371ms    612.092082ms    224.231675ms             N/A             N/A
javascript       medium.js    7.677477849s    7.482421823s    998.785937ms             N/A             N/A
javascript        large.js  1m6.400202811s  1m4.000824787s    7.639953592s             N/A             N/A
```
