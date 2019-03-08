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
    python        small.py    132.086896ms    122.016969ms     94.131337ms         4.584ms         2.711ms
    python       medium.py    2.250895022s    2.290513407s    731.000492ms         91.18ms        57.452ms
    python        large.py    3.941208693s    3.783453672s    1.181489655s       144.873ms        99.715ms
      java      small.java    148.958943ms    116.308406ms    194.478548ms           926ms           545ms
      java     medium.java    1.144835917s     1.18516998s    324.903252ms          1129ms           807ms
      java      large.java    3.124446842s     3.12652269s    642.784387ms          1387ms           739ms
javascript        small.js    119.511385ms     95.919546ms     95.376741ms             N/A             N/A
javascript       medium.js    1.343736427s    1.326996308s    186.233408ms             N/A             N/A
javascript        large.js    9.684985783s    9.762940077s    663.904669ms             N/A             N/A


$ COUNT=100 ON_HOST=1 bash ./run.sh
Process 100 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host
    python        small.py       3.088015s     2.58812815s    568.464827ms        69.886ms        44.111ms
    python       medium.py   52.297365534s   51.247135437s    12.55262038s       873.491ms       219.037ms
    python        large.py 1m22.507091656s 1m14.481106886s    21.70040739s        45.812ms       146.826ms
      java      small.java    3.056292436s    2.213988294s    867.268716ms          1477ms           987ms
      java     medium.java   24.554742702s   21.145548326s    2.595436212s          3841ms          2396ms
      java      large.java 1m17.546950453s 1m12.211801797s     5.12169814s          2308ms          1822ms
javascript        small.js      2.1606058s    1.772258858s    250.882644ms             N/A             N/A
javascript       medium.js   25.687663424s   25.647269622s    1.248257934s             N/A             N/A
javascript        large.js 3m30.478925267s 3m30.672862594s    8.477405331s             N/A             N/A
```
