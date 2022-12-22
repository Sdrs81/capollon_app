import 'package:capollon_app/views/AboutPage.dart';
import 'package:capollon_app/views/FavoritesPage.dart';
import 'package:capollon_app/views/MainPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: mainDart(),
    );
  }
}

class mainDart extends StatefulWidget {
  const mainDart({Key? key}) : super(key: key);

  @override
  State<mainDart> createState() => _mainDartState();
}

class _mainDartState extends State<mainDart> {

  int pageIndex = 0;
  var pageList = [MainPage(), FavoritesPage(), AboutPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home Page",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: "About",
          ),
        ],
        currentIndex: pageIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        backgroundColor: Colors.blue,
        onTap: (index){
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }
}





