import 'package:capollon_app/stateManagement/ProviderCryptoCoinList.dart';
import 'package:capollon_app/stateManagement/ProviderForFavoriteCoins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../model/CryptoCoins.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  Future<void> transportValuesFromSharedPreferencesToProviderForFavoriteCoins() async{
    var sharedPFavoriteCoinList = await SharedPreferences.getInstance();
    Provider.of<ProviderForFavoriteCoins>(context, listen: true).setListOfFavoriteCoins(sharedPFavoriteCoinList.getStringList("favoriteCoins")!);
  }

  Future<List<CryptoCoins>> showAllCoins() async{

    var coinList = <CryptoCoins>[];

    var c1 = CryptoCoins("1", "1", "BTC", "Bitcoin", "100000","123456" , "20000", "5");
    var c2 = CryptoCoins("2", "2", "ETH", "Etherium", "50055", "123456","1000", "4");
    var c3 = CryptoCoins("3", "3", "XRP", "XRP coin", "15205", "123456","1500", "3");
    var c4 = CryptoCoins("1", "1", "BTC", "Bitcoin", "100000","123456" , "20000", "5");
    var c5 = CryptoCoins("2", "2", "ETH", "Etherium", "50055", "123456","1000", "4");
    var c6 = CryptoCoins("3", "3", "XRP", "XRP coin", "15205", "123456","1500", "3");

    coinList.add(c1);
    coinList.add(c2);
    coinList.add(c3);
    coinList.add(c4);
    coinList.add(c5);
    coinList.add(c6);

    return coinList;
  }

  @override
  void initState() {
    super.initState();
    showAllCoins();
    transportValuesFromSharedPreferencesToProviderForFavoriteCoins();
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
          if(snapshot.hasData){                                           // provider sorunu
            var coinList = snapshot.data;
            var favoriteCoinList = Provider.of<ProviderForFavoriteCoins>(context);
            //Provider.of<ProviderCryptoCoinList>(context, listen: false).setListOfAllCoins(coinList!);   // Set provider crypto coin list with updated values
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: coinList!.length,
              itemBuilder: (context, indeks){
                var coin = coinList[indeks];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  color: Colors.primaries[indeks % Colors.primaries.length],
                  child: SizedBox(
                    height: 130,
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
                                  const Text("Rank# ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                                  Text(coin.rank, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
                                ],
                              ),
                              //Text(coin.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),),
                              Row(
                                children: [
                                  readyText(coin.name,Colors.white, FontWeight.bold, 22),
                                  Text(" (${coin.symbol})", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                                ],
                              ),
                              favoriteCoinList.isContain(coin.id) ?
                              IconButton(
                                icon: Icon(Icons.favorite, color: Colors.white,),
                                onPressed: (){
                                  favoriteCoinList.remove(coin.id);
                                },
                              ):
                              IconButton(
                                icon: Icon(Icons.favorite_border, color: Colors.white,),
                                onPressed: (){
                                  favoriteCoinList.add(coin.id);
                                },
                              )
                            ],
                          ),
                          Container(
                            height: 1,
                            color: Colors.white,
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  const Text("Current Price: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),),
                                  Text("${coin.priceUsd} \$", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text("Change(24Hr): ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),),
                                  Text("${coin.changePercent24Hr}%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                                ],
                              ),
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


// Ready to go widgets for more clear code
class readyText extends StatelessWidget{

  late final String text;
  late final Color color;
  late final FontWeight fontWeight;
  late final double fontSize;

  readyText(this.text, this.color, this.fontWeight, this.fontSize);

  @override
  Widget build(BuildContext context){
    return Text(text, style: TextStyle(color: color, fontWeight: fontWeight, fontSize: fontSize));
  }
}