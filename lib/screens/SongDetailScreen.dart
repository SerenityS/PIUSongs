import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SongDetailScreen extends StatefulWidget {
  @override
  _SongDetailScreenState createState() => _SongDetailScreenState();
}

class _SongDetailScreenState extends State<SongDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final songData = Get.arguments;
  late List stepCharts = songData['stepChart'].keys.toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  _launchYoutube(title, level) async {
    if (level.contains('C')) {
      level = 'Co-Op';
    }
    String searchArgs = title + " " + level;
    String url =
        'https://m.youtube.com/results?sp=mAEA&search_query=$searchArgs';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }

    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
            child: Text(
              "${songData['songTitle_ko']}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 7.5),
          Text(
            "${songData['songArtist_ko']}",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
          SizedBox(height: 15),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image(
                image:
                    AssetImage('assets/songJacket/${songData['songNo']}.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            child: TabBar(
              labelColor: Color(0xFF343434),
              labelStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFFc9c9c9),
                  fontWeight: FontWeight.w700),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                insets: EdgeInsets.fromLTRB(45.0, 0.0, 45.0, 0.0),
              ),
              unselectedLabelColor: Color(0xFFc9c9c9),
              unselectedLabelStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFFc9c9c9),
                  fontWeight: FontWeight.w700),
              controller: _tabController,
              tabs: [
                Tab(text: "채보 목록"),
                Tab(text: "상세 정보"),
              ],
            ),
          ),
          SizedBox(height: 18),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  child: ListView.builder(
                    itemCount: stepCharts.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            Fluttertoast.showToast(
                              msg: "길게 클릭하면 채보 영상을 검색합니다.",
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          },
                          onLongPress: () {
                            _launchYoutube(
                                songData['songTitle_en'], stepCharts[i]);
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15.0, 5.0, 5.0, 5.0),
                            child: Row(
                              children: <Widget>[
                                Image(
                                  image: AssetImage(
                                      'assets/level/${stepCharts[i]}.png'),
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "${songData['stepChart'][stepCharts[i]]}",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(18.0, 5.0, 5.0, 5.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text("제목",
                                        style: TextStyle(fontSize: 16)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text("제목(영문명)",
                                        style: TextStyle(fontSize: 16)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text("작곡가",
                                        style: TextStyle(fontSize: 16)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text("작곡가(영문명)",
                                        style: TextStyle(fontSize: 16)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text("BPM",
                                        style: TextStyle(fontSize: 16)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text("유형",
                                        style: TextStyle(fontSize: 16)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text("채널",
                                        style: TextStyle(fontSize: 16)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text(
                                  "수록 버전",
                                  style: TextStyle(fontSize: 16),
                                ))),
                          ],
                        ),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text(songData['songTitle_ko'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text(songData['songTitle_en'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text(songData['songArtist_ko'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text(songData['songArtist_en'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text(songData['songBpm'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54)))),
                            SizedBox(height: 4),
                            SizedBox(
                                height: 25,
                                child: Center(
                                    child: Text(songData['songType'],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54)))),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 25,
                              child: Center(
                                child: Text(
                                  songData['songSeriesChannel'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 25,
                              child: Center(
                                child: Text(
                                  songData['songSeries'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
