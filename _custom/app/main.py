import json
from json import decoder
import requests
import json


r = requests.get('http://localhost:8070', stream=True)

buffer = ""

for line in r.iter_lines():
    linestr = line.decode("utf-8")
    buffer += linestr

    if(linestr=="},"):
        buffer += "}"
        print(buffer)
        buffer == ""
