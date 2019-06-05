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

* `semantic` - grpc calls to bblfsh server using client-go with semantic mode
* `bblfshd` - grpc calls to bblfsh server using client-go with native mode
* `driver` - grpc calls to bblfsh driver using client-go (speaks the same protocol)
* `native` - writes file multiple times to stdin of native driver
* `naive` - the simplest ast parser I came up with, run on docker
* `naive-on-host` - same as previous one but without docker
* `go-tree-sitter` - use [go bindings](https://github.com/smacker/go-tree-sitter) to [tree-sitter](https://github.com/tree-sitter/tree-sitter)

### Results on my machine:

```
$ ON_HOST=1 bash ./run.sh
Process 5 times each file
  language         fixture        semantic         bblfshd          driver          native           naive   naive-on-host  go-tree-sitter
    python        small.py    116.539749ms     48.942962ms     75.004011ms     92.446857ms         3.929ms         2.366ms       543.973µs
    python       medium.py    1.599836916s     755.27236ms     979.88242ms    696.572664ms        89.275ms        66.455ms      19.01192ms
    python        large.py    2.768434027s    1.177480743s    1.162664989s    1.008075686s       143.129ms        92.805ms     29.868624ms
      java      small.java     80.484111ms     59.553298ms      37.44783ms    113.524303ms           791ms           382ms       410.546µs
      java     medium.java    732.765797ms    417.917357ms    396.369231ms    304.240967ms           976ms           468ms      6.776931ms
      java      large.java    1.804763297s    973.179411ms    1.024198953s    635.750094ms          1238ms           622ms     20.349097ms
javascript        small.js     66.474485ms     59.514451ms     29.010792ms     79.058312ms             N/A             N/A       248.365µs
javascript       medium.js    940.515048ms    275.866322ms    288.755713ms    191.805473ms             N/A             N/A      6.614362ms
javascript        large.js    6.971718088s     1.97325413s    1.871911764s    506.326851ms             N/A             N/A     41.406852ms


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
