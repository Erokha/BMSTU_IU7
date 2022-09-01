import json

def getJSON(data):
    if data is None:
        return json.dumps(dict())
    return json.dumps(data)

def getErrorJSON(reason: str):
    data = {"status": "error", "reason": reason}
    return getJSON(data)

def parseJSONArray(data):
    return json.loads(data)

