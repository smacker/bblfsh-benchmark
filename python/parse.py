import sys
import ast
from datetime import datetime, timedelta


def parse(path: str, times: int) -> timedelta:
    content = open(path).read()

    start = datetime.now()

    for _ in range(times):
        tree = ast.parse(content)
        ast.dump(tree)

    return datetime.now() - start


print(str(parse(sys.argv[1], int(sys.argv[2])).microseconds / 1000) + "ms")
