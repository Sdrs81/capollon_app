
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderForFavoriteCoins extends ChangeNotifier{
  List<String> favoriteCoinList = [];

  List<String> getListOfFavoriteCoins(){
    return favoriteCoinList;
  }

  void setListOfFavoriteCoins(List<String> list){
    favoriteCoinList = list;
    notifyListeners();
  }

  Future <void> add(String coinId) async{
    var sharedPFavoriteCoinList = await SharedPreferences.getInstance();
    favoriteCoinList.add(coinId);
    notifyListeners();

    sharedPFavoriteCoinList.remove("favoriteCoins");
    var sharedPList = <String>[];

    for(var coinId in favoriteCoinList){
      sharedPList.add(coinId);
    }

    sharedPFavoriteCoinList.setStringList("favoriteCoins", sharedPList);
  }

  Future<void> remove(String coinId) async{
    var sharedPFavoriteCoinList = await SharedPreferences.getInstance();
    favoriteCoinList.remove(coinId);
    notifyListeners();

    sharedPFavoriteCoinList.remove("favoriteCoins");
    var sharedPList = <String>[];

    for(var coinId in favoriteCoinList){
      sharedPList.add(coinId);
    }

    sharedPFavoriteCoinList.setStringList("favoriteCoins", sharedPList);
  }

  bool isContain(String coinId){
    return favoriteCoinList.contains(coinId);
  }


}