import json
import requests
import json


r = requests.get('http://localhost:8070', stream=True)

buffer = ""

for line in r.iter_lines():
    linestr = line.decode("utf-8")

    # Ignore first opening array
    if(linestr.strip() == "["):
        continue

    if(linestr.strip()=="},"):
        buffer ="[" + buffer + "}]"

        obj = json.loads(buffer)
        print(obj)
        buffer = ""

    else:
        buffer += linestr
