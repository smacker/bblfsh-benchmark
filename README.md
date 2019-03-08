# Benchmarks for bblfsh

Mesure bblfsh overhead compare to native parser and tree-sitter.

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
* `go-tree-sitter` - use [go bindings](https://github.com/smacker/go-tree-sitter) to [tree-sitter](https://github.com/tree-sitter/tree-sitter)

### Results on my machine:

```
$ ON_HOST=1 bash ./run.sh
Process 5 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host  go-tree-sitter
    python        small.py      59.10137ms     42.014634ms      84.21925ms          3.58ms         2.762ms      550.371µs
    python       medium.py    730.150815ms    729.288617ms    611.847338ms        82.215ms        54.739ms     15.530973ms
    python        large.py    1.150602363s    1.154730518s    931.864116ms       134.487ms        90.282ms     26.114348ms
      java      small.java     56.840603ms     41.636917ms    137.319559ms           785ms           520ms      486.784µs
      java     medium.java     373.38844ms    362.152399ms    277.792368ms           886ms           466ms      6.793929ms
      java      large.java    925.527857ms    979.785512ms    387.941378ms          1109ms           624ms     19.834719ms
javascript        small.js     45.961269ms      27.30678ms     82.676786ms             N/A             N/A      283.666µs
javascript       medium.js      254.6304ms    261.169542ms    164.598177ms             N/A             N/A      7.162936ms
javascript        large.js    1.835414117s    1.786695238s    501.930811ms             N/A             N/A     40.761878ms


$ COUNT=100 ON_HOST=1 bash ./run.sh
Process 100 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host  go-tree-sitter
    python        small.py    1.079530842s    951.732776ms     496.97266ms        66.981ms          62.3ms     17.947399ms
    python       medium.py   16.580967699s    15.30512511s    11.38071154s       660.534ms        87.742ms    333.089036ms
    python        large.py   23.077634855s   23.000140787s   17.953921045s       657.431ms       855.178ms    554.306883ms
      java      small.java     1.01676893s    924.874297ms    742.826628ms          1166ms           621ms      8.143652ms
      java     medium.java    8.302661273s    9.015791504s    2.231004422s          1756ms          1353ms    180.167101ms
      java      large.java   23.286575316s   21.001132587s    5.846483831s          3192ms          2031ms    426.856856ms
javascript        small.js    936.368807ms    1.138111259s    294.129059ms             N/A             N/A      7.987509ms
javascript       medium.js    9.023018705s    8.008308402s    1.274347629s             N/A             N/A     119.60978ms
javascript        large.js   39.277155259s   36.693041699s    5.515874603s             N/A             N/A    719.868076ms
```
