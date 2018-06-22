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
    python        small.py     50.018363ms     38.327857ms     62.582703ms         2.973ms         2.438ms
    python       medium.py    769.000307ms    700.378132ms    470.544701ms        63.529ms        56.479ms
    python        large.py    1.275609266s    1.208969896s    743.146561ms        108.06ms        98.175ms
      java      small.java     79.420286ms      61.27143ms     97.523015ms           565ms           392ms
      java     medium.java    434.359772ms    818.780743ms    230.666002ms           649ms           474ms
      java      large.java    1.055102355s    926.712473ms    438.603635ms           804ms           601ms
javascript        small.js     51.882459ms     45.574277ms      38.25892ms             N/A             N/A
javascript       medium.js     459.00891ms    477.979698ms    115.557562ms             N/A             N/A
javascript        large.js    3.350241623s    3.092466151s    518.193587ms             N/A             N/A

$ COUNT=100 ON_HOST=1 bash ./run.sh
Process 100 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host
    python        small.py    876.589984ms    864.273892ms    367.053954ms        53.373ms        41.943ms
    python       medium.py    15.44547128s   14.506398946s    8.138650093s       238.057ms        98.578ms
    python        large.py   25.603619179s   24.060433655s   13.597760383s       140.954ms       883.599ms
      java      small.java    832.753743ms    714.972591ms    570.079146ms           821ms           615ms
      java     medium.java    6.633346407s    6.105927809s    1.541059131s          1337ms          1066ms
      java      large.java   18.244999317s   16.653970706s     2.90125654s          1833ms          1571ms
javascript        small.js    691.724174ms    600.730657ms    154.411162ms             N/A             N/A
javascript       medium.js    7.731778101s    7.154430796s    1.076294969s             N/A             N/A
javascript        large.js  1m2.024899947s   58.445313369s     8.07498884s             N/A             N/A
```
