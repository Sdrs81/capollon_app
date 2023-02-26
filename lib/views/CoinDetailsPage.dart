import 'dart:convert';

import 'package:capollon_app/model/CryptoCoins.dart';
import 'package:capollon_app/model/CryptoMarketDatas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stateManagement/ProviderForFavoriteCoins.dart';
import 'package:http/http.dart' as http;


class CoinDetailsPage extends StatefulWidget {

  CryptoCoins coin;
  int index;

  CoinDetailsPage({required this.coin,required this.index});

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {

  // Parsing API response for market datas
  List<CryptoMarketDatas> parseResponseOfMarketDatas(String response){

    var jsonData = json.decode(response);
    var jsonArray = jsonData["data"] as List;

    List<CryptoMarketDatas> marketDatasList = jsonArray.map((jsonArrayObject) => CryptoMarketDatas.fromJson(jsonArrayObject)).toList();

    return marketDatasList;
  }

  // Getting market datas from API
  Future<List<CryptoMarketDatas>> showMarketDatas() async{

      var url = Uri.parse("https://api.coincap.io/v2/assets/${widget.coin.id}/markets");
      var response = await http.get(url);

      return parseResponseOfMarketDatas(response.body);
  }


  @override
  Widget build(BuildContext context) {

    // Initializing Provider class to check favorite attribute for coins
    var favoriteCoinListProvider = Provider.of<ProviderForFavoriteCoins>(context);

    // Defining Market Names for listing them
    var selectedMarketList = <String>["Binance",  "Bitfinex", "Quoine", "Okex", "Bithumb", "Coinbase Pro",
      "Huobi", "Coinbene", "HitBTC", "Bit-Z", "Bitflyer", "Bitstamp", "ZB", "Kraken", "LBank", "Itbit", "Allcoin"];


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Coin Details: ${widget.coin.name}",),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Colors.primaries[widget.index % Colors.primaries.length],
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
                              Text(widget.coin.rank, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              readyText(widget.coin.name,Colors.white, FontWeight.bold, 20),
                              Text(" (${widget.coin.symbol})", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                            ],
                          ),
                          favoriteCoinListProvider.containsCoin(widget.coin.id) ?
                          Consumer<ProviderForFavoriteCoins>(
                            builder: (context, ProviderObject, child){
                              return IconButton(
                                icon: Icon(Icons.favorite, color: Colors.white,),
                                onPressed: (){
                                  ProviderObject.remove(widget.coin.id);
                                },
                              );
                            },
                          ):
                          Consumer<ProviderForFavoriteCoins>(
                            builder: (context, ProviderObject, child){
                              return IconButton(
                                icon: Icon(Icons.favorite_border, color: Colors.white,),
                                onPressed: (){
                                  ProviderObject.add(widget.coin.id);
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
                              Text("${double.parse(widget.coin.priceUsd).toStringAsFixed(5)} \$", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                            ],
                          ),
                          Column(
                            children: [
                              const Text("Change(24Hr): ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),),
                              Text("${double.parse(widget.coin.changePercent24Hr).toStringAsFixed(2)}%", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Colors.primaries[widget.index % Colors.primaries.length],
              child: SizedBox(
                height: 170,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Additional Informations",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      Container(
                        height: 1,
                        color: Colors.white,
                      ),
                      Container(height: 5),
                      Column(
                        children: [
                          const Text("Current Supply (Amount): ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),),
                          Container(height: 3),
                          Text("${double.parse(widget.coin.supply).round()}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                        ],
                      ),
                      Container(height: 5),
                      Column(
                        children: [
                          const Text("Volume USD (24Hr): ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),),
                          Container(height: 3),
                          Text("${double.parse(widget.coin.volumeUsd24Hr).toStringAsFixed(2)} \$", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    color: Colors.primaries[widget.index % Colors.primaries.length],
                    child: SizedBox(
                      height: 60,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Price datas from different Markets:", style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            widget.coin.id.contains("tether") ?
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Colors.primaries[widget.index % Colors.primaries.length],
              child: SizedBox(
                height: 75,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("There are no market datas for tether, because it is a 'Stable coin' .", style: TextStyle(color: Colors.white, fontSize: 17),textAlign: TextAlign.center,),
                    ],
                  ),
                ),
              ),
            )
            : Expanded(
              flex: 1,
              child: FutureBuilder<List<CryptoMarketDatas>>(
                future: showMarketDatas(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    var marketDatasList = snapshot.data;

                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: marketDatasList!.length,
                      itemBuilder: (context, index){
                        var marketData = marketDatasList[index];
                        if(((selectedMarketList.contains(marketData.exchangeId)) && marketData.quoteId == "tether") && widget.coin.id != "tether"){
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            color: Colors.primaries[widget.index % Colors.primaries.length],
                            child: SizedBox(
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Market: ${marketData.exchangeId}", style: TextStyle(color: Colors.white, fontSize: 17),),
                                    Text("Price: ${double.parse(marketData.priceUsd).toStringAsFixed(5)} \$", style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }else{
                          return Container(
                            width: 0,
                            height: 0,
                          );
                        }
                      },
                    );
                  }else{
                    return Center();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

