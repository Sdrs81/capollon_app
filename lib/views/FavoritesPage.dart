import 'package:flutter/material.dart';


class FavoritesPage extends StatefulWidget {

  //var favoriteCoinsList = <CryptoCoins>[];
  //FavoritesPage({required this.favoriteCoinsList});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: Center(),
    );
  }
}
