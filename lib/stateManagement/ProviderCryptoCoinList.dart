import 'package:flutter/material.dart';

import '../model/CryptoCoins.dart';

class ProviderCryptoCoinList extends ChangeNotifier{

  List<CryptoCoins> cryptoCoinList = [];

  List<CryptoCoins> getListOfAllCoins(){
    return cryptoCoinList;
  }

  void setListOfAllCoins(List<CryptoCoins> list){
    cryptoCoinList = list;
    notifyListeners();
  }

}