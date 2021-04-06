import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piu_songs/screens/SongDetailScreen.dart';
import 'package:piu_songs/screens/SongListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      title: 'PIU Songs',
      initialRoute: '/songlist',
      getPages: [
        GetPage(name: '/songlist', page: () => SongListScreen()),
        GetPage(name: '/songdetail', page: () => SongDetailScreen()),
      ],
    );
  }
}