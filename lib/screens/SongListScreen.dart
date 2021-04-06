import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SongListScreen extends StatefulWidget {
  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
  TextEditingController _searchString = new TextEditingController();

  String chartType = 'ALL';
  String levelValue = 'ALL';

  List songListData = [];

  late List level;
  List<String> levels = [];
  List songNoList = [];

  @override
  void initState() {
    super.initState();
    loadSongJsonData();
    makeLevelList();
  }

  Future loadSongJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/songLists.json');
    setState(
      () => songListData = json.decode(jsonText),
    );
  }

  makeLevelList() async {
    if (chartType == 'ALL') {
      setState(
        () {
          levelValue = 'ALL';
          levels = ['ALL'];
        },
      );
    } else {
      var jsonText = await rootBundle.loadString('assets/json/$chartType.json');
      level = json.decode(jsonText);
      levels = [];

      setState(
        () {
          levelValue = level[0]['stepLevel'];
          for (var i = 0; i < level.length; i++) {
            levels.add(level[i]['stepLevel']);
          }
        },
      );
    }
    makeSongList();
  }

  makeSongList() {
    if (chartType == 'ALL') {
      songNoList = ['ALL'];
    } else {
      for (var i = 0; i < level.length; i++) {
        if (level[i]['stepLevel'] == levelValue) {
          songNoList = level[i]['stepCharts'];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PIU Songs"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                child: DropdownButton<String>(
                  value: chartType,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  onChanged: (newValue) {
                    setState(
                      () {
                        chartType = newValue!;
                        makeLevelList();
                      },
                    );
                  },
                  items: <String>['ALL', 'S', 'D', 'SP', 'DP', 'CO-OP']
                      .map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: DropdownButton<String>(
                  value: levelValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blueAccent,
                  ),
                  onChanged: (newValue) {
                    setState(
                      () {
                        levelValue = newValue!;
                        makeSongList();
                      },
                    );
                  },
                  items: levels.map(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    },
                  ).toList(),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 10),
                  child: SizedBox(
                    width: 10,
                    height: 30,
                    child: TextField(
                      controller: _searchString,
                      onChanged: (text) {
                        setState(
                          () {
                            SongListScreen();
                          },
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: songListData.length,
              itemBuilder: (BuildContext context, int index) {
                var songNo = songListData[index]['songNo'];
                var songTitleKo = songListData[index]['songTitle_ko'];
                var songTitleEn =
                    songListData[index]['songTitle_en'].toLowerCase();
                var songArtistKo = songListData[index]['songArtist_ko'];
                var songArtistEn =
                    songListData[index]['songArtist_en'].toLowerCase();

                if ((songNoList[0] == 'ALL' || songNoList.contains(songNo)) &&
                    (songTitleKo.contains(_searchString.text) ||
                        songTitleEn
                            .contains(_searchString.text.toLowerCase()) ||
                        songArtistKo.contains(_searchString.text) ||
                        songArtistEn
                            .contains(_searchString.text.toLowerCase()))) {
                  return ListTile(
                    dense: false,
                    leading: CircleAvatar(
                      radius: 28.0,
                      backgroundImage:
                          AssetImage('assets/songJacket/$songNo.png'),
                    ),
                    title: Text(songTitleKo),
                    subtitle: Text(songArtistKo),
                  );
                } else {
                  return SizedBox(height: 0);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
