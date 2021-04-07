import json

with open('../assets/json/songLists.json', encoding='utf-8') as f:
    songList = json.load(f)

for t in ['S', 'SP', 'D', 'DP', 'C']:
    totalJson = []
    for j in range(1, 29):
        f = {}
        newJson = []
        lvs = "{:02d}".format(j)
        for i in range(1, 10000):
            try:
                if songList[i]['stepChart'][f'{t}{lvs}']:
                    newJson.append(songList[i]['songNo'])
            except:
                pass

        if len(newJson) != 0:
            f['stepLevel'] = f'{lvs}'
            f['stepCharts'] = newJson
            totalJson.append(f)

    if t == "C":
        t = "CO-OP"
    with open(f'../assets/json/{t}.json', 'w', encoding='utf-8') as f:
        json.dump(totalJson, f, sort_keys=True, indent=4, ensure_ascii=False)
