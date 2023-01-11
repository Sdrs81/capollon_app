
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

  // Checking that coin list whether it is empty or not
  bool isCoinListEmpty(){
    return cryptoCoinList.isEmpty;
  }

}