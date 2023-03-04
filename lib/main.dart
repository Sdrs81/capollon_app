import 'package:capollon_app/stateManagement/ProviderCryptoCoinList.dart';
import 'package:capollon_app/stateManagement/ProviderForFavoriteCoins.dart';
import 'package:capollon_app/views/AboutPage.dart';
import 'package:capollon_app/views/FavoritesPage.dart';
import 'package:capollon_app/views/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderCryptoCoinList()),
        ChangeNotifierProvider(create: (context) => ProviderForFavoriteCoins()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: mainDart(),
      ),
    );
  }
}

class mainDart extends StatefulWidget {
  const mainDart({Key? key}) : super(key: key);

  @override
  State<mainDart> createState() => _mainDartState();
}

class _mainDartState extends State<mainDart> {

  // Variables for BottomNavigationBar
  // try
  int pageIndex = 0;
  var pageList = [MainPage(), FavoritesPage(), AboutPage()];

  // Transporting values from sharedPreferences to Provider to get favorites
  Future<void> transportValuesFromSharedPreferencesToProviderForFavoriteCoins() async {
    var sharedP = await SharedPreferences.getInstance();
    var coinFavoriteCoinListFromSharedPReferences = sharedP.getStringList(
        "favoriteCoins") ?? <String>[];
    var favoriteCoinList = Provider.of<ProviderForFavoriteCoins>(context, listen: false);

    for (var coinId in coinFavoriteCoinListFromSharedPReferences) {
      favoriteCoinList.add(coinId);
    }
  }

  @override
  void initState() {
    super.initState();
    transportValuesFromSharedPreferencesToProviderForFavoriteCoins();
  }

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
        backgroundColor: Colors.indigo,
        onTap: (index){
          setState(() {
            pageIndex = index;
          });
        },
      ),
    );
  }
}





