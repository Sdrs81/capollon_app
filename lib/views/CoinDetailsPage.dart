import 'package:capollon_app/model/CryptoCoins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stateManagement/ProviderForFavoriteCoins.dart';

class CoinDetailsPage extends StatefulWidget {

  CryptoCoins coin;
  int index;

  CoinDetailsPage({required this.coin,required this.index});

  @override
  State<CoinDetailsPage> createState() => _CoinDetailsPageState();
}

class _CoinDetailsPageState extends State<CoinDetailsPage> {
  @override
  Widget build(BuildContext context) {

    // Initializing Provider class to check favorite attribute for coins
    var favoriteCoinListProvider = Provider.of<ProviderForFavoriteCoins>(context);

    return Scaffold(
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
                      Column(
                        children: [
                          const Text("Supply: ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),),
                          Text("${double.parse(widget.coin.supply).round()}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Volume USD(24Hr): ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 19),),
                          Text("${double.parse(widget.coin.volumeUsd24Hr).toStringAsFixed(2)}", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),),
                        ],
                      ),
                    ],
                  ),
                ),
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
