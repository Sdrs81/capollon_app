import 'package:capollon_app/stateManagement/ProviderCryptoCoinList.dart';
import 'package:capollon_app/stateManagement/ProviderForFavoriteCoins.dart';
import 'package:capollon_app/views/CoinDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/CryptoCoins.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  // Variables for search option
  bool isSearchModeOn = false;
  String searchedWord = "";

  // Parsing API response
  List<CryptoCoins> parseResponseOfAllCoins(String response){

    var jsonData = json.decode(response);
    var jsonArray = jsonData["data"] as List;

    List<CryptoCoins> coinList = jsonArray.map((jsonArrayObject) => CryptoCoins.fromJson(jsonArrayObject)).toList();

    return coinList;
  }

  // Getting all coin datas from API
  Future<List<CryptoCoins>> showAllCoins() async{

    if(Provider.of<ProviderCryptoCoinList>(context, listen: false).isCoinListEmpty()){

      var url = Uri.parse("https://api.coincap.io/v2/assets");
      var response = await http.get(url);

      WidgetsBinding.instance.addPostFrameCallback((_){
        Provider.of<ProviderCryptoCoinList>(context, listen: false).setListOfAllCoins(parseResponseOfAllCoins(response.body));
      });
      return parseResponseOfAllCoins(response.body);

    }else{
      return Future.value(Provider.of<ProviderCryptoCoinList>(context, listen: false).getListOfAllCoins());
    }
  }

  // Searching function
  Future<List<CryptoCoins>> showSearchedCoins(String searchedWord) async{

    Future <List<CryptoCoins>> coinList = Future.value(Provider.of<ProviderCryptoCoinList>(context, listen: false).getListOfAllCoins());

    List<CryptoCoins> normalCoinList = await coinList;
    List<CryptoCoins> searchedCoinList = <CryptoCoins>[];

    for(var coin in normalCoinList){
      if(coin.id.contains(searchedWord.toLowerCase())){
        searchedCoinList.add(coin);
      }
    }

    return searchedCoinList;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearchModeOn ?
        TextField(
          style: TextStyle(color: Colors.white),
          autofocus: true,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: "Search coin from here...",
            hintStyle: new TextStyle(
                color: Colors.white
            ),
            border: InputBorder.none
          ),
          onChanged: (searchResult){
            print("Search Result: $searchResult");
            setState(() {
              searchedWord = searchResult;
            });
          },
        ) : Text("Capollon"),
        actions: [
          isSearchModeOn ?
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: (){
              setState(() {
                isSearchModeOn = false;
                searchedWord = "";
              });
            },
          ) : IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              setState(() {
                isSearchModeOn = true;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<CryptoCoins>>(
        future: isSearchModeOn ? showSearchedCoins(searchedWord) : showAllCoins(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var coinList = snapshot.data;
            // Initializing Provider class to check favorite attribute for coins
            var favoriteCoinListProvider = Provider.of<ProviderForFavoriteCoins>(context);
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: coinList!.length,
              itemBuilder: (context, index){
                var coin = coinList[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CoinDetailsPage(coin: coin, index: index,)));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    color: Colors.primaries[index % Colors.primaries.length],
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
                                    Text(coin.rank, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    readyText(coin.name,Colors.white, FontWeight.bold, 20),
                                    Text(" (${coin.symbol})", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                                  ],
                                ),
                                favoriteCoinListProvider.containsCoin(coin.id) ?
                                Consumer<ProviderForFavoriteCoins>(
                                  builder: (context, ProviderObject, child){
                                    return IconButton(
                                      icon: Icon(Icons.favorite, color: Colors.white,),
                                      onPressed: (){
                                        ProviderObject.remove(coin.id);
                                      },
                                    );
                                  },
                                ):
                                Consumer<ProviderForFavoriteCoins>(
                                  builder: (context, ProviderObject, child){
                                    return IconButton(
                                      icon: Icon(Icons.favorite_border, color: Colors.white,),
                                      onPressed: (){
                                        ProviderObject.add(coin.id);
                                      },
                                    );
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
                                    Text("${double.parse(coin.priceUsd).toStringAsFixed(5)} \$", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text("Change(24Hr): ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),),
                                    Text("${double.parse(coin.changePercent24Hr).toStringAsFixed(2)}%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
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

// Ready Text
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