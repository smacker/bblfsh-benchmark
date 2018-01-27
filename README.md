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
    python        large.py    1.415933469s    1.285575202s    1.056378351s       106.845ms        90.437ms
      java      large.java    981.940711ms    946.995218ms    1.775752736s           827ms           766ms

$ COUNT=100 ON_HOST=1 bash ./run.sh
Process 100 times each file
  language         fixture         bblfshd          driver          native           naive   naive-on-host
    python        large.py   28.671434528s   27.547217133s   14.888383486s       192.308ms       972.743ms
      java      large.java   18.702677221s   17.198674757s    5.002113491s          1937ms          1660ms
```
