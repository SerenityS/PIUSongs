import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        fontFamily: 'SourceHanSans',
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.grey,
        primaryIconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      themeMode: ThemeMode.light,
      title: 'PIU Songs',
      initialRoute: '/songlist',
      getPages: [
        GetPage(name: '/songdetail', page: () => SongDetailScreen()),
        GetPage(name: '/songlist', page: () => SongListScreen()),
      ],
    );
  }
}