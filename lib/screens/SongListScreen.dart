import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SongListScreen extends StatefulWidget {
  @override
  _SongListScreenState createState() => _SongListScreenState();
}

class _SongListScreenState extends State<SongListScreen> {
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
    songListData = json.decode(jsonText);
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
      body: ListView.builder(
        itemCount: songListData.length,
        itemBuilder: (BuildContext context, int index) {
          var songNo = songListData[index]['songNo'];
          var songTitleKo = songListData[index]['songTitle_ko'];
          var songTitleEn = songListData[index]['songTitle_en'].toLowerCase();
          var songArtistKo = songListData[index]['songArtist_ko'];
          var songArtistEn = songListData[index]['songArtist_en'].toLowerCase();

          return ListTile(
            dense: false,
            leading: CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage('assets/songJacket/$songNo.png'),
            ),
            title: Text(songTitleKo),
            subtitle: Text(songArtistKo),
          );
        },
      ),
    );
  }
}
