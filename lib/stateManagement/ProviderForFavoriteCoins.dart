
import 'package:flutter/material.dart';

class ProviderForFavoriteCoins extends ChangeNotifier{
  List<String> favoriteCoinList = [];

  List<String> getListOfFavoriteCoins(){
    return favoriteCoinList;
  }

  void setListOfFavoriteCoins(List<String> list){
    favoriteCoinList = list;
    notifyListeners();
  }



}