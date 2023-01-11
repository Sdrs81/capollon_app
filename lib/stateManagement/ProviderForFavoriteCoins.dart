
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

  // Adding new favorite coin to SharedPreferences and Provider
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

  // Removing favorite coin from SharedPreferences and Provider
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

  // Checking that coin whether it is in the favorite list or not
  bool containsCoin(String coinId){
    return favoriteCoinList.contains(coinId);
  }

  // Checking that favorite list whether it is empty or not
  bool isFavoriteListEmpty(){
    return favoriteCoinList.isEmpty;
  }


}