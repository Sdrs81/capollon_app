import 'package:flutter/material.dart';

import '../entity/CryptoCoins.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Future<List<CryptoCoins>> showAllCoins() async{
    var coinList = <CryptoCoins>[];

    var c1 = CryptoCoins("1", "1", "BTC", "Bitcoin", "100000", "20000", "5");
    var c2 = CryptoCoins("2", "2", "ETH", "Etherium", "50055", "1000", "4");
    var c3 = CryptoCoins("3", "3", "XRP", "XRP coin", "15205", "1500", "3");

    coinList.add(c1);
    coinList.add(c2);
    coinList.add(c3);

    return coinList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Capollon App"),
      ),
      body: FutureBuilder<List<CryptoCoins>>(
        future: showAllCoins(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var coinList = snapshot.data;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: coinList!.length,
              itemBuilder: (context, indeks){
                var coin = coinList[indeks];
                return Card(
                  color: Colors.pinkAccent,
                  child: SizedBox(
                    height: 120,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("Rank# ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                                  Text(coin.rank, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                                ],
                              ),
                              Text(coin.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                              Text("(${coin.symbol})", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Current Price: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                              Text(coin.priceUsd, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }else{
            return Center();
          }
        },
      ),
    );
  }
}
