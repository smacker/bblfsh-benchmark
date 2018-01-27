# Benchmarks for bblfsh

### how to run

```bash
$ docker-compose up
$ ./run.sh
```

Set environment variables to control `run.sh`:

* `COUNT` - how many times run process file
* `ON_HOST` - run naive parser on host machine

### Results on my machine:

```
$ ON_HOST=1 bash ./run.sh
Process 5 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host
    python        small.py     61.215061ms     42.833176ms    621.673341ms         4.908ms         4.192ms
    python       medium.py    1.127560473s    857.403292ms    906.899886ms        70.859ms        64.159ms
    python        large.py    1.518151045s      1.4659905s    1.156931304s       120.057ms       111.605ms
      java      small.java     89.666777ms     78.965098ms    1.503619314s           602ms           529ms
      java     medium.java    423.871159ms    466.446233ms    1.703299444s           699ms           509ms
      java      large.java    993.402146ms    953.508301ms    1.712879739s           749ms           603ms

$ COUNT=100 ON_HOST=1 bash ./run.sh
Process 100 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host
    python        small.py    1.089309078s    838.284074ms    789.031826ms         52.27ms        52.136ms
    python       medium.py   17.170260464s   15.767907072s    8.580979614s       272.756ms       104.036ms
    python        large.py   29.487305351s   29.092154604s   14.361370198s       302.273ms        39.235ms
      java      small.java     867.22452ms    676.824974ms    1.828750374s           722ms           615ms
      java     medium.java     7.15959583s    6.132769692s    2.915804402s          1378ms          1038ms
      java      large.java   17.763698203s   15.743125287s    4.029628459s          2027ms          1634ms
```
