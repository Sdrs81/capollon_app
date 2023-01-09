
import 'package:flutter/material.dart';

import '../model/CryptoCoins.dart';

class ProviderCryptoCoinList extends ChangeNotifier{

  List<CryptoCoins> cryptoCoinList = [];

  Future <List<CryptoCoins>> getListOfAllCoins() async{
    return cryptoCoinList;
  }

  Future <void> setListOfAllCoins(List<CryptoCoins> list) async{
    cryptoCoinList = list;
    notifyListeners();
  }

  bool isEmpty(){
    return cryptoCoinList.isEmpty;
  }

}